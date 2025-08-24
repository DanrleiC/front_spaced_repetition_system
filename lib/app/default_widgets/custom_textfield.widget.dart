import 'package:flutter/material.dart';
import 'package:front_spaced_repetition_system/app/utils/colors_app.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool readOnly;
  final int maxLines;
  final Widget? prefixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.prefixIcon,
    this.hint = '',
    this.validator,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.readOnly = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      validator: validator ??
          (value) {
            if (value == null || value.trim().isEmpty) {
              return 'O campo "$label" não pode ficar vazio';
            }
            return null;
          },
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon,
        errorStyle: TextStyle(
          fontWeight: FontWeight.bold
        ),
        labelStyle: TextStyle(color: ColorsApp.labelField),
        focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorsApp.borderField)),
        enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorsApp.borderField)),
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: ColorsApp.fieldBackground, 
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }
}
