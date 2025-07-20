import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_spaced_repetition_system/app/features/homepage/widgets/deck_card.widget.dart';
import 'package:front_spaced_repetition_system/app/utils/colors_app.dart';

class HomePageScreen extends ConsumerWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      body: content(),
      backgroundColor: ColorsApp.background,
    );
  }

  Widget content() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: [
          DeckCard(
            title: 'Tittle',
            description: 'desc',
          )
        ],
      ),
    );
  }
}