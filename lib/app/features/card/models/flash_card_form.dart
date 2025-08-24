import 'package:front_spaced_repetition_system/app/features/card/models/flash_card_midia.dart';

class FlashcardFormState {
  final String question;
  final String answer;
  final List<FlashcardMedia> frontMedia;
  final List<FlashcardMedia> backMedia;
  final String? editingCardId;

  const FlashcardFormState({
    this.question = '',
    this.answer = '',
    this.frontMedia = const [],
    this.backMedia = const [],
    this.editingCardId,
  });

  FlashcardFormState copyWith({
    String? question,
    String? answer,
    List<FlashcardMedia>? frontMedia,
    List<FlashcardMedia>? backMedia,
    String? editingCardId,
  }) {
    return FlashcardFormState(
      question: question ?? this.question,
      answer: answer ?? this.answer,
      frontMedia: frontMedia ?? this.frontMedia,
      backMedia: backMedia ?? this.backMedia,
      editingCardId: editingCardId ?? this.editingCardId,
    );
  }

  FlashcardFormState clearForm() {
    return const FlashcardFormState();
  }

  bool get isEditing => editingCardId != null;
  bool get canSave => question.trim().isNotEmpty && answer.trim().isNotEmpty;
}