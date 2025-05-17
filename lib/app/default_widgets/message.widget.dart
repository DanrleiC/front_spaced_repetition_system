import 'package:flutter/material.dart';
import 'package:front_spaced_repetition_system/app/utils/colors_app.dart';

class WelcomeMessage extends StatelessWidget {
  
  final String title;
  final String subTitle;

  const WelcomeMessage({
    required this.title,
    required this.subTitle,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 27,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2),
        Text(
          subTitle,
          style: TextStyle(
            fontSize: 15.5,
            color: ColorsApp.labelField,
          ),
        ),
      ],
    );
  }
}
