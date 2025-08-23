import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_spaced_repetition_system/app/features/deck/controller/deck_creation.dart';
import 'package:front_spaced_repetition_system/app/features/deck/widgets/deck_form.dart';
import 'package:front_spaced_repetition_system/app/features/homepage/controller/decks.controller.dart';
import 'package:front_spaced_repetition_system/app/utils/alert_helper.dart';
import 'package:front_spaced_repetition_system/app/utils/colors_app.dart';
import 'package:front_spaced_repetition_system/app/utils/toast_helper.dart';

class DeckCreateDialog extends ConsumerWidget {
  const DeckCreateDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();

    final state = ref.watch(deckCreateControllerProvider);

    final isLoading = state is AsyncLoading;

    return AbsorbPointer(
      absorbing: isLoading,
      child: Stack(
        children: [
          AlertDialog(
            backgroundColor: ColorsApp.background,
            title: const Center(
              child: Text(
                'Crie seu Deck',
                style: TextStyle(color: ColorsApp.freedom),
              ),
            ),

            content: DeckForm(
              formKey: formKey,
              nameController: nameController,
              descriptionController: descriptionController,
            ),

            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Cancelar',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await ref.read(deckCreateControllerProvider.notifier).createDeck(
                      name: nameController.text,
                      description: descriptionController.text,
                    );

                    final result = ref.read(deckCreateControllerProvider);

                    result.whenOrNull(
                      data: (_) {
                        ref.invalidate(decksProvider);

                        ToastHelper.showSuccess(context: context, message: 'Deck registrado com sucesso!');

                        Navigator.of(context).pop();
                      },
                      error: (err, _) {
                        AlertHelper.showError(context: context, message: err.toString());
                      },
                    );
                  }
                },
                child: isLoading
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: ColorsApp.mainPurple,
                      ),
                    )
                  : const Text('Confirmar', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          if (isLoading)
            Positioned.fill(
            child: Container(
              color: Colors.white.withValues(alpha: 0.7),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
