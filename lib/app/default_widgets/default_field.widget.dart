import 'package:flutter/material.dart';
import 'package:front_spaced_repetition_system/app/features/login/widget/field_email_pwd.widget.dart';
import 'package:front_spaced_repetition_system/app/utils/colors_app.dart';

class FieldDefault extends StatefulWidget {
  final String label;
  final bool useEmailPwd;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const FieldDefault({
    this.suffixIcon,
    this.keyboardType,
    required this.label,
    this.useEmailPwd = false,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    super.key,
  });

  @override
  State<FieldDefault> createState() => _FieldDefaultState();
}

class _FieldDefaultState extends State<FieldDefault> {

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        errorStyle: TextStyle(
          fontWeight: FontWeight.bold
        ),
        labelText: label,
        labelStyle: TextStyle(color: ColorsApp.labelField),
        focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorsApp.borderField)),
        enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorsApp.borderField)),
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: ColorsApp.fieldBackground, 
        suffixIcon: widget.suffixIcon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nameField = _buildTextField(
      controller: widget.nameController,
      label: widget.label,
    );

    if (!widget.useEmailPwd) return nameField;

    return Column(
      children: [
        nameField,
        const SizedBox(height: 20),
        FieldEmailPwd(
          emailController: widget.emailController,
          passwordController: widget.passwordController,
        ),
      ],
    );
  }
}
