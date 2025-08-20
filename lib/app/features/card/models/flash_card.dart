import 'package:front_spaced_repetition_system/app/features/card/models/flash_card_midia.dart';

class Flashcard {
  final String id;
  final String question;
  final String answer;
  final FlashcardMedia frontMedia;
  final FlashcardMedia backMedia;
  final DateTime createdAt;

  const Flashcard({
    required this.id,
    required this.question,
    required this.answer,
    this.frontMedia = const FlashcardMedia(),
    this.backMedia = const FlashcardMedia(),
    required this.createdAt,
  });

  Flashcard copyWith({
    String? id,
    String? question,
    String? answer,
    FlashcardMedia? frontMedia,
    FlashcardMedia? backMedia,
    DateTime? createdAt,
  }) {
    return Flashcard(
      id: id ?? this.id,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      frontMedia: frontMedia ?? this.frontMedia,
      backMedia: backMedia ?? this.backMedia,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}