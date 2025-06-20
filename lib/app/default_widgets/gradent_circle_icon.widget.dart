import 'package:flutter/material.dart';
import 'package:front_spaced_repetition_system/app/utils/colors_app.dart';

class GradientCircleIcon extends StatelessWidget {
  final double size;
  final String assetPath;
  final double iconSize;
  final double borderRadius;

  const GradientCircleIcon({
    super.key,
    required this.assetPath,
    this.size = 60.0,
    this.iconSize = 30.0,
    this.borderRadius = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          colors: [
            ColorsApp.mainPurple,
            ColorsApp.mainMagent,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child:  Image.asset(
          assetPath,
          width: iconSize,
          height: iconSize,
          fit: BoxFit.contain,
          color: Colors.white,
        )
      ),
    );
  }
}
