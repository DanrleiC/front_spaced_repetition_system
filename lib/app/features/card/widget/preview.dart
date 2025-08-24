import 'package:flutter/material.dart';
import 'dart:io';

import 'package:front_spaced_repetition_system/app/features/card/models/flash_card_midia.dart';
import 'package:front_spaced_repetition_system/app/utils/colors_app.dart';

class FlashcardPreviewWidget extends StatelessWidget {
  final String title;
  final String content;
  final List<FlashcardMedia> media;
  final VoidCallback? onAddImage;
  final VoidCallback? onAddAudio;
  final VoidCallback? onRemoveImage;
  final VoidCallback? onRemoveAudio;
  final bool showAudioOption;

  const FlashcardPreviewWidget({
    super.key,
    required this.title,
    required this.content,
    required this.media,
    this.onAddImage,
    this.onAddAudio,
    this.onRemoveImage,
    this.onRemoveAudio,
    this.showAudioOption = false,
  });

  bool get hasImage => media.any((m) => m.isImage);
  bool get hasAudio => media.any((m) => m.isAudio);

  FlashcardMedia? get imageMedia => media.firstWhere((m) => m.isImage);
  FlashcardMedia? get audioMedia => media.firstWhere((m) => m.isAudio,);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: ColorsApp.fieldBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (content.isNotEmpty)
                          Expanded(
                            child: SingleChildScrollView(
                              child: Text(
                                content,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          )
                        else
                          Expanded(
                            child: Center(
                              child: Text(
                                'Digite o conteúdo...',
                                style: TextStyle(
                                  color: ColorsApp.freedom,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                        if (hasImage && imageMedia?.path != null) ...[
                          const SizedBox(height: 8),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(imageMedia!.path!),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey.shade200,
                                    child: const Icon(Icons.error),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                        if (hasAudio && audioMedia?.path != null) ...[
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.blue.shade200),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.audiotrack, color: Colors.blue, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  'Áudio anexado',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            if (hasImage)
              _buildActionChip(
                label: 'Remover Imagem',
                icon: Icons.delete,
                onPressed: onRemoveImage,
                color: Colors.red,
              )
            else
              _buildActionChip(
                label: 'Adicionar Imagem',
                icon: Icons.image,
                onPressed: onAddImage,
                color: Colors.blue,
              ),
            if (showAudioOption) ...[
              if (hasAudio)
                _buildActionChip(
                  label: 'Remover Áudio',
                  icon: Icons.delete,
                  onPressed: onRemoveAudio,
                  color: Colors.red,
                )
              else
                _buildActionChip(
                  label: 'Adicionar Áudio',
                  icon: Icons.audiotrack,
                  onPressed: onAddAudio,
                  color: Colors.green,
                ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildActionChip({
    required String label,
    required IconData icon,
    required VoidCallback? onPressed,
    required Color color,
  }) {
    return ActionChip(
      label: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
        ),
      ),
      avatar: Icon(icon, size: 16, color: color),
      onPressed: onPressed,
      backgroundColor: color.withValues(alpha: 0.1),
      side: BorderSide(color: color.withValues(alpha: 0.3)),
    );
  }
}