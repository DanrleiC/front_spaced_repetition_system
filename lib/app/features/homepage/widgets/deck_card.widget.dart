import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_spaced_repetition_system/app/default_widgets/gradent_circle_icon.widget.dart';
import 'package:front_spaced_repetition_system/app/utils/colors_app.dart';

class DeckCard extends StatelessWidget {
  final String title;
  final String description;
  final String assetPath;

  const DeckCard({
    super.key,
    required this.title,
    required this.description,
    this.assetPath = 'assets/cards.png',
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: ColorsApp.cardBackgound,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GradientCircleIcon(
                      assetPath: assetPath,
                      borderRadius: 12,
                      size: 50,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: TextStyle(
                        color: ColorsApp.freedom,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Icon(
                  FontAwesomeIcons.ellipsisVertical,
                  color: ColorsApp.freedom,
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                color: ColorsApp.labelField,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
