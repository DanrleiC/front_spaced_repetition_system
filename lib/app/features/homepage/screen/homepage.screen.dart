import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_spaced_repetition_system/app/features/homepage/controller/decks.controller.dart';
import 'package:front_spaced_repetition_system/app/features/homepage/models/deck.model.dart';
import 'package:front_spaced_repetition_system/app/features/homepage/widgets/deck_card.widget.dart';
import 'package:front_spaced_repetition_system/app/utils/colors_app.dart';
import 'package:responsive_layout_grid/responsive_layout_grid.dart';

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
      data: (decks) => SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: ResponsiveLayoutGrid(
          minimumColumnWidth: 200,
          columnGutterWidth: 5,
          rowGutterHeight: 5,
          padding: const EdgeInsets.all(0),
          children: decks.map((deck) {
            return ResponsiveLayoutCell(
              columnSpan: ColumnSpan.remainingWidth(preferred: 1),
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