class FlashcardMedia {
  final String? imagePath;
  final String? audioPath;

  const FlashcardMedia({
    this.imagePath,
    this.audioPath,
  });

  FlashcardMedia copyWith({
    String? imagePath,
    String? audioPath,
  }) {
    return FlashcardMedia(
      imagePath: imagePath ?? this.imagePath,
      audioPath: audioPath ?? this.audioPath,
    );
  }

  bool get hasImage => imagePath != null && imagePath!.isNotEmpty;
  bool get hasAudio => audioPath != null && audioPath!.isNotEmpty;
  bool get hasMedia => hasImage || hasAudio;
}
