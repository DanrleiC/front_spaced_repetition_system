import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_spaced_repetition_system/app/features/login/provider/login.provider.dart';
import 'package:front_spaced_repetition_system/app/utils/colors_app.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double borderRadius;
  final double minWidth;
  final double minHeight;
  final List<Color> gradientColors;

  const GradientButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.borderRadius = 7.0,
    this.minWidth = 150,
    this.minHeight = 48,
    this.gradientColors = const [
      ColorsApp.mainPurple,
      ColorsApp.mainMagent,
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final isLoading = ref.watch(loginControllerProvider).isLoading;

        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradientColors),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Container(
              alignment: Alignment.center,
              constraints:
                BoxConstraints(minWidth: minWidth, minHeight: minHeight),
                child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                  text,
                  style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
