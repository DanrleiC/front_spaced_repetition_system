import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_spaced_repetition_system/app/features/card/models/flash_card.dart';
import 'package:front_spaced_repetition_system/app/features/card/models/flash_card_deck.dart';
import 'package:front_spaced_repetition_system/app/features/card/models/flash_card_form.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class FlashcardDeckNotifier extends StateNotifier<FlashcardDeck> {
  FlashcardDeckNotifier() : super(
    FlashcardDeck(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: '',
      description: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  );

  void updateDeckInfo(String name, String description) {
    state = state.copyWith(
      name: name,
      description: description,
      updatedAt: DateTime.now(),
    );
  }

  void addCard(Flashcard card) {
    final updatedCards = [...state.cards, card];
    state = state.copyWith(
      cards: updatedCards,
      updatedAt: DateTime.now(),
    );
  }

  void updateCard(Flashcard updatedCard) {
    final updatedCards = state.cards.map((card) {
      return card.id == updatedCard.id ? updatedCard : card;
    }).toList();
    
    state = state.copyWith(
      cards: updatedCards,
      updatedAt: DateTime.now(),
    );
  }

  void removeCard(String cardId) {
    final updatedCards = state.cards.where((card) => card.id != cardId).toList();
    state = state.copyWith(
      cards: updatedCards,
      updatedAt: DateTime.now(),
    );
  }

  void moveCard(int oldIndex, int newIndex) {
    if (oldIndex < 0 || oldIndex >= state.cards.length ||
        newIndex < 0 || newIndex >= state.cards.length) {
      return;
    }

    final updatedCards = [...state.cards];
    final card = updatedCards.removeAt(oldIndex);
    updatedCards.insert(newIndex, card);
    
    state = state.copyWith(
      cards: updatedCards,
      updatedAt: DateTime.now(),
    );
  }

  void moveCardUp(int index) {
    if (index > 0) {
      moveCard(index, index - 1);
    }
  }

  void moveCardDown(int index) {
    if (index < state.cards.length - 1) {
      moveCard(index, index + 1);
    }
  }

  void resetDeck() {
    state = FlashcardDeck(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: '',
      description: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}

class FlashcardFormNotifier extends StateNotifier<FlashcardFormState> {
  FlashcardFormNotifier() : super(const FlashcardFormState());

  final ImagePicker _imagePicker = ImagePicker();

  void updateQuestion(String question) {
    state = state.copyWith(question: question);
  }

  void updateAnswer(String answer) {
    state = state.copyWith(answer: answer);
  }

  Future<void> pickFrontImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      
      if (image != null) {
        final updatedMedia = state.frontMedia.copyWith(imagePath: image.path);
        state = state.copyWith(frontMedia: updatedMedia);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> pickBackImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      
      if (image != null) {
        final updatedMedia = state.backMedia.copyWith(imagePath: image.path);
        state = state.copyWith(backMedia: updatedMedia);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> pickBackAudio() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        final updatedMedia = state.backMedia.copyWith(audioPath: result.files.single.path);
        state = state.copyWith(backMedia: updatedMedia);
      }
    } catch (e) {
      rethrow;
    }
  }

  void removeFrontImage() {
    final updatedMedia = state.frontMedia.copyWith(imagePath: '');
    state = state.copyWith(frontMedia: updatedMedia);
  }

  void removeBackImage() {
    final updatedMedia = state.backMedia.copyWith(imagePath: '');
    state = state.copyWith(backMedia: updatedMedia);
  }

  void removeBackAudio() {
    final updatedMedia = state.backMedia.copyWith(audioPath: '');
    state = state.copyWith(backMedia: updatedMedia);
  }

  void loadCardForEditing(Flashcard card) {
    state = FlashcardFormState(
      question: card.question,
      answer: card.answer,
      frontMedia: card.frontMedia,
      backMedia: card.backMedia,
      editingCardId: card.id,
    );
  }

  void clearForm() {
    state = const FlashcardFormState();
  }

  Flashcard createCard() {
    return Flashcard(
      id: state.editingCardId ?? DateTime.now().millisecondsSinceEpoch.toString(),
      question: state.question.trim(),
      answer: state.answer.trim(),
      frontMedia: state.frontMedia,
      backMedia: state.backMedia,
      createdAt: DateTime.now(),
    );
  }
}

// Providers
final flashcardDeckProvider = StateNotifierProvider<FlashcardDeckNotifier, FlashcardDeck>((ref) => FlashcardDeckNotifier());

final flashcardFormProvider = StateNotifierProvider<FlashcardFormNotifier, FlashcardFormState>((ref) => FlashcardFormNotifier());
