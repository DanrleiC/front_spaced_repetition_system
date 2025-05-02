import 'package:flutter/material.dart';
import 'package:front_spaced_repetition_system/app/utils/colors_app.dart';

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: null,
      child: Text(
        'Esqueceu sua senha?',
        style: TextStyle(
          color: ColorsApp.mainPurple,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}