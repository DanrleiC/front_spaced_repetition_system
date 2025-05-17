// login_controller.dart
import 'package:riverpod/riverpod.dart';

class UserController extends StateNotifier<AsyncValue<void>> {
  UserController() : super(const AsyncData(null));

  Future<void> creationUsr({required String name, required String email, required String password}) async {
    state = const AsyncLoading();
    try {
      //todo
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
