import 'package:flutter/material.dart';
import 'package:front_spaced_repetition_system/app/utils/colors_app.dart';

class FieldEmailPwd extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const FieldEmailPwd({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<FieldEmailPwd> createState() => _FieldEmailPwdState();
}

class _FieldEmailPwdState extends State<FieldEmailPwd> {
  bool _obscurePassword = true;

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
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
        suffixIcon: suffixIcon,
      ),
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTextField(
          controller: widget.emailController,
          label: 'Email',
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, insira o e-mail';
            }
            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
              return 'Insira um e-mail válido';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: widget.passwordController,
          label: 'Senha',
          obscureText: _obscurePassword,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, insira a senha';
            }
            return null;
          },
          suffixIcon: IconButton(
            icon: Icon(
              color: ColorsApp.labelField,
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              setState(() => _obscurePassword = !_obscurePassword);
            },
          ),
        ),
      ],
    );
  }
}
