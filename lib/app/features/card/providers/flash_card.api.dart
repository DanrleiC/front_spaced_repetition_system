import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_spaced_repetition_system/app/features/card/controller/flash_card.controller.dart';
import 'package:front_spaced_repetition_system/app/features/card/models/flash_card.dart';
import 'package:front_spaced_repetition_system/app/features/card/models/flash_card_deck.dart';
import 'package:front_spaced_repetition_system/app/features/card/models/flash_card_form.dart';
import 'package:front_spaced_repetition_system/app/features/card/providers/flash_card.dart';

final flashcardsProvider = FutureProvider.family<List<Flashcard>, String>((ref, deckId) async {
  final controller = ref.watch(flashcardsControllerProvider);
  return controller.getAllCards(deckId);
});

final flashcardDeckProvider = StateNotifierProvider<FlashcardDeckNotifier, FlashcardDeck>((ref) => FlashcardDeckNotifier());

final flashcardFormProvider = StateNotifierProvider<FlashcardFormNotifier, FlashcardFormState>((ref) => FlashcardFormNotifier());
