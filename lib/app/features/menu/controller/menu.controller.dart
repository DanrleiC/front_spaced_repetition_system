import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_spaced_repetition_system/app/repository/provider/api_service.provider.dart';

final getUserProvider = FutureProvider.autoDispose((ref) async {
  final api = ref.read(apiServiceProvider);
  final data = await api.get('/users/profile');
  return data['username'];
});

class UserNameNotifier {
  final ValueNotifier<String> usernameNotifier = ValueNotifier('');

  // Função para atualizar o ValueNotifier com o username do provider
  Future<void> loadUsername(WidgetRef ref) async {
    final usernameAsync = await ref.read(getUserProvider.future);
    usernameNotifier.value = usernameAsync;
  }

  void dispose() {
    usernameNotifier.dispose();
  }
}