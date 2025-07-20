import 'package:flutter/material.dart';
import 'package:front_spaced_repetition_system/app/utils/colors_app.dart';

class ModalEditProfile{
  static void showEditUsernameDialog({
    required BuildContext context,
    required ValueNotifier<String> username,
  }) {
    final controller = TextEditingController(text: username.value);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorsApp.cardBackgound,
          title: const Text(
            'Editar Perfil',
            style: TextStyle(color: ColorsApp.freedom),
          ),
          content: TextField(
            controller: controller,
            style: const TextStyle(color: ColorsApp.freedom),
            decoration: InputDecoration(
              hintText: 'Digite seu nome',
              hintStyle: const TextStyle(color: ColorsApp.labelField),
              filled: true,
              fillColor: ColorsApp.fieldBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: ColorsApp.labelField),
              ),
            ),
            TextButton(
              child: const Text(
                'Salvar',
                style: TextStyle(color: ColorsApp.labelField),
              ),
              onPressed: () async {
                username.value = controller.text.trim();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
