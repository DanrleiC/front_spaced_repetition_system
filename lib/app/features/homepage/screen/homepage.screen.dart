import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_spaced_repetition_system/app/features/homepage/controller/decks.controller.dart';
import 'package:front_spaced_repetition_system/app/features/homepage/models/deck.model.dart';
import 'package:front_spaced_repetition_system/app/features/homepage/widgets/deck_card.widget.dart';
import 'package:front_spaced_repetition_system/app/utils/colors_app.dart';

class HomePageScreen extends ConsumerWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decksController = ref.watch(decksProvider);

    return Scaffold(
      body: content(decksController),
      backgroundColor: ColorsApp.background,
    );
  }

  Widget content(AsyncValue<List<DeckModel>> decksController) {
    return decksController.when(
      data: (List<DeckModel> decks) => SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: decks.map((deck) {
            return SizedBox(
              width: 200, // ou outro valor que funcione bem no seu layout
              child: DeckCard(
                title: deck.name,
                description: deck.description,
              ),
            );
          }).toList(),
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Erro: $e')),
    );
  }
}