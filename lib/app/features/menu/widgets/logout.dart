import 'package:flutter/material.dart';
import 'package:front_spaced_repetition_system/app/utils/colors_app.dart';

class LogoutDialog {
  static void show(BuildContext context, VoidCallback onConfirmLogout) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorsApp.cardBackgound,
          title: const Text(
            'Sair',
            style: TextStyle(color: ColorsApp.freedom),
          ),
          content: const Text(
            'Tem certeza que deseja sair?',
            style: TextStyle(color: ColorsApp.labelField),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: ColorsApp.labelField),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirmLogout(); // chama a função de logout
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Sair'),
            ),
          ],
        );
      },
    );
  }
}
