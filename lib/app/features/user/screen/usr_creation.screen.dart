import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_spaced_repetition_system/app/default_widgets/default_field.widget.dart';
import 'package:front_spaced_repetition_system/app/default_widgets/gradent_circle_icon.widget.dart';
import 'package:front_spaced_repetition_system/app/features/login/widget/gradient_button.widget.dart';
import 'package:front_spaced_repetition_system/app/default_widgets/message.widget.dart';
import 'package:front_spaced_repetition_system/app/features/user/provider/user.provider.dart';
import 'package:front_spaced_repetition_system/app/utils/colors_app.dart';

class UserCreationScreen extends ConsumerStatefulWidget {
  const UserCreationScreen({super.key});

  @override
  ConsumerState<UserCreationScreen> createState() => _UserCreationScreenState();
}

class _UserCreationScreenState extends ConsumerState<UserCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _creation() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      await ref.read(userControllerProvider.notifier).creationUsr(name: name, email: email, password: password);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(userControllerProvider, (previous, next) {
      next.whenOrNull(
        data: (_) {
          Navigator.popAndPushNamed(context, '/');
        },
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        },
      );
    });

    return Scaffold(
      backgroundColor: ColorsApp.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 500
            ),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: ColorsApp.cardBackgound,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    GradientCircleIcon(assetPath: 'assets/user-add-icon.png'),
                    const SizedBox(height: 20),
                    const WelcomeMessage(title: 'Crie sua conta', subTitle: 'Preencha os campos abaixo para se cadastrar',),
                    const SizedBox(height: 20),
                    FieldDefault(
                      label: 'Nome',
                      useEmailPwd: true,
                      nameController: _nameController,
                      emailController: _emailController,
                      passwordController: _passwordController,
                    ),
                    const SizedBox(height: 20),
                    GradientButton(onPressed: _creation, text: 'Cadastrar-se'),
                    const SizedBox(height: 20),
                    const SizedBox(height: 10),
                    Divider(color: ColorsApp.labelField, thickness: 0.2),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
