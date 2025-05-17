import 'package:flutter/material.dart';
import 'package:front_spaced_repetition_system/app/utils/colors_app.dart';

class RegisterText extends StatelessWidget {
  final VoidCallback onPressed;

  const RegisterText({
    required this.onPressed,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Não tem uma conta? ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorsApp.labelField,
            )
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: GestureDetector(
              onTap: onPressed,
              child: Text(
                'Cadastre-se',
                style: TextStyle(
                  color: ColorsApp.mainPurple,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}