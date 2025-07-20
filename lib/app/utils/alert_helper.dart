import 'package:flutter/material.dart';

enum AlertType {
  success,
  error,
  warning,
  info,
}

class AlertHelper {
  // Método estático para mostrar alertas
  static Future<void> showAlert({
    required BuildContext context,
    required String title,
    required String message,
    required AlertType type,
    String? confirmButtonText,
    String? cancelButtonText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool barrierDismissible = true,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              _getIcon(type),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: _getColor(type),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 8,
          actions: _buildActions(
            context: context,
            type: type,
            confirmButtonText: confirmButtonText,
            cancelButtonText: cancelButtonText,
            onConfirm: onConfirm,
            onCancel: onCancel,
          ),
        );
      },
    );
  }

  // Método para alertas de sucesso
  static Future<void> showSuccess({
    required BuildContext context,
    required String message,
    String title = 'Sucesso',
    String confirmButtonText = 'OK',
    VoidCallback? onConfirm,
  }) async {
    return showAlert(
      context: context,
      title: title,
      message: message,
      type: AlertType.success,
      confirmButtonText: confirmButtonText,
      onConfirm: onConfirm,
    );
  }

  // Método para alertas de erro
  static Future<void> showError({
    required BuildContext context,
    required String message,
    String title = 'Erro',
    String confirmButtonText = 'OK',
    VoidCallback? onConfirm,
  }) async {
    return showAlert(
      context: context,
      title: title,
      message: message,
      type: AlertType.error,
      confirmButtonText: confirmButtonText,
      onConfirm: onConfirm,
    );
  }

  // Método para alertas de aviso
  static Future<void> showWarning({
    required BuildContext context,
    required String message,
    String title = 'Atenção',
    String confirmButtonText = 'OK',
    VoidCallback? onConfirm,
  }) async {
    return showAlert(
      context: context,
      title: title,
      message: message,
      type: AlertType.warning,
      confirmButtonText: confirmButtonText,
      onConfirm: onConfirm,
    );
  }

  // Método para alertas informativos
  static Future<void> showInfo({
    required BuildContext context,
    required String message,
    String title = 'Informação',
    String confirmButtonText = 'OK',
    VoidCallback? onConfirm,
  }) async {
    return showAlert(
      context: context,
      title: title,
      message: message,
      type: AlertType.info,
      confirmButtonText: confirmButtonText,
      onConfirm: onConfirm,
    );
  }

  // Método para alertas de confirmação
  static Future<bool?> showConfirmation({
    required BuildContext context,
    required String message,
    String title = 'Confirmação',
    String confirmButtonText = 'Confirmar',
    String cancelButtonText = 'Cancelar',
  }) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              const Icon(
                Icons.help_outline,
                color: Colors.orange,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 8,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                cancelButtonText,
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(confirmButtonText),
            ),
          ],
        );
      },
    );
  }

  // Método privado para obter o ícone baseado no tipo
  static Widget _getIcon(AlertType type) {
    switch (type) {
      case AlertType.success:
        return const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 28,
        );
      case AlertType.error:
        return const Icon(
          Icons.error,
          color: Colors.red,
          size: 28,
        );
      case AlertType.warning:
        return const Icon(
          Icons.warning,
          color: Colors.orange,
          size: 28,
        );
      case AlertType.info:
        return const Icon(
          Icons.info,
          color: Colors.blue,
          size: 28,
        );
    }
  }

  // Método privado para obter a cor baseada no tipo
  static Color _getColor(AlertType type) {
    switch (type) {
      case AlertType.success:
        return Colors.green;
      case AlertType.error:
        return Colors.red;
      case AlertType.warning:
        return Colors.orange;
      case AlertType.info:
        return Colors.blue;
    }
  }

  // Método privado para construir os botões de ação
  static List<Widget> _buildActions({
    required BuildContext context,
    required AlertType type,
    String? confirmButtonText,
    String? cancelButtonText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    List<Widget> actions = [];

    // Botão de cancelar (se fornecido)
    if (cancelButtonText != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (onCancel != null) onCancel();
          },
          child: Text(
            cancelButtonText,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    // Botão de confirmar
    actions.add(
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
          if (onConfirm != null) onConfirm();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _getColor(type),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(confirmButtonText ?? 'OK'),
      ),
    );

    return actions;
  }
}