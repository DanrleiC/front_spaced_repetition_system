import 'package:flutter/material.dart';
import 'package:front_spaced_repetition_system/app/utils/colors_app.dart';

class UsernameDisplay extends StatelessWidget {
  final ValueNotifier<String> username;

  const UsernameDisplay({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder<String>(
          valueListenable: username,
          builder: (context, value, child) {
            return Text(
              value,
              style: const TextStyle(
                color: ColorsApp.freedom,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder<String>(
          valueListenable: username,
          builder: (context, value, child) {
            return Text(
              '@${value.toLowerCase().replaceAll(' ', '')}',
              style: const TextStyle(
                color: ColorsApp.labelField,
                fontSize: 16,
              ),
            );
          },
        ),
      ],
    );
  }
}
