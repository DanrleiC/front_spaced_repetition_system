// login_controller.dart
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

import '../../../utils/routes.dart';

class LoginController extends StateNotifier<AsyncValue<void>> {
  LoginController() : super(const AsyncData(null));

  Future<void> login({required BuildContext context, required String email, required String password}) async {
    state = const AsyncLoading();
    try {
      // await authRepository.login(email, password);
      Navigator.pushNamed(context, AppRoutes.homepage);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
