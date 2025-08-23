import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_spaced_repetition_system/app/default_widgets/gradent_circle_icon.widget.dart';
import 'package:front_spaced_repetition_system/app/features/card/screens/flash_card.screen.dart';
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
              _buildSmallLayout(),
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

  Widget _buildSmallLayout() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GradientCircleIcon(
              assetPath: assetPath,
              borderRadius: 12,
              size: 35,
            ),
            PopupMenuButton<String>(
            icon: const Icon(
                FontAwesomeIcons.ellipsisVertical,
                color: ColorsApp.freedom,
              ),
            onSelected: (String value) {
              print(value);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Editar',
                child: Text('Editar'),
              ),
              const PopupMenuItem<String>(
                value: 'Excluir',
                child: Text('Excluir'),
              ),
              PopupMenuItem<String>(
                value: 'addCard',
                child: Text('Adicionar Cards'),
                onTap: () 
                => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FlashcardCreatorScreen(),
                  ),
                )
              ),
            ],
          ),
          ],
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(
              color: ColorsApp.freedom,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}