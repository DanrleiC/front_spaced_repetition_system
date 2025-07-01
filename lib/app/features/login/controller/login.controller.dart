import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_spaced_repetition_system/app/repository/provider/api_service.provider.dart';
import '../../../utils/routes.dart';

final loginControllerProvider = StateNotifierProvider<LoginController, AsyncValue<void>>((ref) => LoginController(ref));

class LoginController extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  LoginController(this.ref) : super(const AsyncData(null));

  Future<void> login({ required BuildContext context, required String email, required String password }) async {
    state = const AsyncLoading();

    try {
      final api = ref.read(apiServiceProvider);

      final response = await api.post('/users/login', body: {
        'email': email,
        'password': password,
      });

      // Exemplo: recebendo o token
      final token = response['token'];

      if (token == null) throw Exception('Token não retornado');

      // Se quiser salvar o token:
      ref.read(authTokenProvider.notifier).state = token;

      // Navegação para a home
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.homepage);
      }

      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}