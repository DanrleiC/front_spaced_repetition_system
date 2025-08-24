import 'package:front_spaced_repetition_system/app/features/card/models/flash_card_midia.dart';

class Flashcard {
  final String id;
  final String deckId;
  final String question;
  final String answer;
  final List<FlashcardMedia> frontMedia;
  final List<FlashcardMedia> backMedia;
  final DateTime? createdAt;
  final DateTime? nextReviewAt;

  const Flashcard({
    required this.id,
    required this.deckId,
    required this.question,
    required this.answer,
    this.frontMedia = const [],
    this.backMedia = const [],
    this.createdAt,
    this.nextReviewAt,
  });

  // Método de fábrica para criar uma instância a partir de dados da API
  factory Flashcard.fromJson(Map<String, dynamic> json) {
    // Busca o texto da frente
    final questionText = json['front']
            ?.firstWhere((item) => item['type'] == 'text', orElse: () => {'text': ''})['text'] ??
        '';

    // Busca o texto de trás
    final answerText = json['back']
            ?.firstWhere((item) => item['type'] == 'text', orElse: () => {'text': ''})['text'] ??
        '';

    // Mapeia a mídia da frente
    final List<FlashcardMedia> frontMediaList = (json['front'] as List? ?? [])
        .where((item) => item['type'] != 'text')
        .map<FlashcardMedia>((item) => FlashcardMedia.fromJson(item))
        .toList();

    // Mapeia a mídia de trás
    final List<FlashcardMedia> backMediaList = (json['back'] as List? ?? [])
        .where((item) => item['type'] != 'text')
        .map<FlashcardMedia>((item) => FlashcardMedia.fromJson(item))
        .toList();

    return Flashcard(
      id: json['id'],
      deckId: json['deckId'],
      question: questionText,
      answer: answerText,
      frontMedia: frontMediaList,
      backMedia: backMediaList,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      nextReviewAt: json['nextReviewAt'] != null ? DateTime.parse(json['nextReviewAt']) : null,
    );
  }

  Flashcard copyWith({
    String? id,
    String? deckId,
    String? question,
    String? answer,
    List<FlashcardMedia>? frontMedia,
    List<FlashcardMedia>? backMedia,
    DateTime? createdAt,
    DateTime? nextReviewAt,
  }) {
    return Flashcard(
      id: id ?? this.id,
      deckId: deckId ?? this.deckId,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      frontMedia: frontMedia ?? this.frontMedia,
      backMedia: backMedia ?? this.backMedia,
      createdAt: createdAt ?? this.createdAt,
      nextReviewAt: nextReviewAt ?? this.nextReviewAt,
    );
  }
}