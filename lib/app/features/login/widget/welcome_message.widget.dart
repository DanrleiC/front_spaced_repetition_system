import 'package:flutter/material.dart';
import 'package:front_spaced_repetition_system/app/utils/colors_app.dart';

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Text(
          'Bem-vindo de volta',
          style: TextStyle(
            fontSize: 27,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2),
        Text(
          'Entre com sua conta para continuar',
          style: TextStyle(
            fontSize: 15.5,
            color: ColorsApp.labelField,
          ),
        ),
      ],
    );
  }
}
