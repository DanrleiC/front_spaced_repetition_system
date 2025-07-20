// login_controller.dart
import 'package:flutter/material.dart';
import 'package:front_spaced_repetition_system/app/repository/api_service_exeption.dart';
import 'package:front_spaced_repetition_system/app/repository/provider/api_service.provider.dart';
import 'package:front_spaced_repetition_system/app/utils/alert_helper.dart';
import 'package:front_spaced_repetition_system/app/utils/routes.dart';
import 'package:riverpod/riverpod.dart';

final userControllerProvider = StateNotifierProvider<UserController, AsyncValue<void>>((ref) => UserController(ref));

class UserController extends StateNotifier<AsyncValue<void>> {
  final Ref ref;
  UserController(this.ref) : super(const AsyncData(null));

  Future<void> creationUsr({required BuildContext context, required String name, required String email, required String password}) async {
    state = const AsyncLoading();

    try {
      final api = ref.read(apiServiceProvider);

      await api.post('/users/register', body: {
        'email': email,
        "username": name,
        'password': password,
      });

      if (context.mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.initial);
      }

      state = const AsyncData(null);
    } on HttpException catch (e, st) {
      state = AsyncError(e, st);
      AlertHelper.showError(context: context, message: e.message);
      rethrow;
    }
  }
}
