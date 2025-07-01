import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:front_spaced_repetition_system/app/default_widgets/gradent_circle_icon.widget.dart';
import 'package:front_spaced_repetition_system/app/default_widgets/message.widget.dart';
import 'package:front_spaced_repetition_system/app/features/login/controller/login.controller.dart';
import 'package:front_spaced_repetition_system/app/features/login/widget/field_email_pwd.widget.dart';
import 'package:front_spaced_repetition_system/app/features/login/widget/forgot_pwd.widget.dart';
import 'package:front_spaced_repetition_system/app/features/login/widget/gradient_button.widget.dart';
import 'package:front_spaced_repetition_system/app/features/login/widget/register_text.widget.dart';
import 'package:front_spaced_repetition_system/app/utils/colors_app.dart';
import 'package:front_spaced_repetition_system/app/utils/routes.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(loginControllerProvider.notifier);
    final state = ref.watch(loginControllerProvider);

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
                    GradientCircleIcon(assetPath: 'assets/cards.png'),
                    const SizedBox(height: 20),
                    const WelcomeMessage(title: 'Bem-vindo de volta', subTitle: 'Entre com sua conta para continuar',),
                    const SizedBox(height: 20),
                    FieldEmailPwd(
                      emailController: _emailController,
                      passwordController: _passwordController,
                    ),
                    const SizedBox(height: 20),
                    GradientButton(
                      onPressed: state.isLoading
                        ? null
                        : () async {
                            await controller.login(
                              context: context,
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                          },
                        text: 'Entrar',
                      ), 
                    const SizedBox(height: 20),
                    ForgotPasswordText(),
                    const SizedBox(height: 10),
                    Divider(color: ColorsApp.labelField, thickness: 0.2),
                    const SizedBox(height: 10),
                    RegisterText(onPressed: () => Navigator.popAndPushNamed(context, AppRoutes.usrCreation))
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
