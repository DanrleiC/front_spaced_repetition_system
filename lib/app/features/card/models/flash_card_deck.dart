import 'package:front_spaced_repetition_system/app/features/card/models/flash_card.dart';

class FlashcardDeck {
  final String id;
  final String name;
  final String description;
  final List<Flashcard> cards;
  final DateTime createdAt;
  final DateTime updatedAt;

  const FlashcardDeck({
    required this.id,
    required this.name,
    required this.description,
    this.cards = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  FlashcardDeck copyWith({
    String? id,
    String? name,
    String? description,
    List<Flashcard>? cards,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FlashcardDeck(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      cards: cards ?? this.cards,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  int get cardCount => cards.length;
  bool get isEmpty => cards.isEmpty;
  bool get isNotEmpty => cards.isNotEmpty;
}