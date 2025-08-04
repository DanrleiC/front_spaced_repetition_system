import 'dart:io';

class FlashCard {
  String id;
  String question;
  String answer;
  File? imgFront;
  File? imgBack;
  File? audio;

  FlashCard({
    required this.id,
    required this.question,
    required this.answer,
    this.imgFront,
    this.imgBack,
    this.audio,
  });
}