import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/colors_app.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const CustomFloatingActionButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.transparent,
      elevation: 7,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorsApp.mainPurple,
              ColorsApp.mainMagent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: const Icon(
            FontAwesomeIcons.plus,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
