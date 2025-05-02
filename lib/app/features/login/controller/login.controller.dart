// login_controller.dart
import 'package:riverpod/riverpod.dart';

class LoginController extends StateNotifier<AsyncValue<void>> {
  LoginController() : super(const AsyncData(null));

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();
    try {
      // await authRepository.login(email, password);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
