import 'dart:io';

class FlashcardMedia {
  final String? path;
  final String? gridFsId;
  final String? contentType;

  const FlashcardMedia({
    this.path,
    this.gridFsId,
    this.contentType,
  });

  factory FlashcardMedia.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return const FlashcardMedia();
    }
    return FlashcardMedia(
      gridFsId: json['gridFsId'],
      contentType: json['contentType'],
    );
  }

  factory FlashcardMedia.fromFile(File file, String contentType) {
    return FlashcardMedia(
      path: file.path,
      contentType: contentType,
    );
  }

  FlashcardMedia copyWith({
    String? path,
    String? gridFsId,
    String? contentType,
  }) {
    return FlashcardMedia(
      path: path ?? this.path,
      gridFsId: gridFsId ?? this.gridFsId,
      contentType: contentType ?? this.contentType,
    );
  }

  bool get hasMedia => path != null || gridFsId != null;

  bool get isImage => contentType?.startsWith('image/') ?? false;

  bool get isVideo => contentType?.startsWith('video/') ?? false;

  bool get isAudio => contentType?.startsWith('audio/') ?? false;
}