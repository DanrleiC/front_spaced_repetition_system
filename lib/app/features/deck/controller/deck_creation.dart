// deck_create.controller.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_spaced_repetition_system/app/repository/provider/api_service.provider.dart';

final deckCreateControllerProvider = StateNotifierProvider<DeckCreateController, AsyncValue<void>>((ref) => DeckCreateController(ref));

class DeckCreateController extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  DeckCreateController(this.ref) : super(const AsyncData(null));

  Future<void> createDeck({
    required String name,
    required String description,
  }) async {
    state = const AsyncLoading();

    try {
      final api = ref.read(apiServiceProvider);

      await api.post('/decks/create/', body: {
        'name': name,
        'description': description,
      });

      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
