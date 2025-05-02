// providers.dart
import 'package:front_spaced_repetition_system/app/features/login/controller/login.controller.dart';
import 'package:riverpod/riverpod.dart';

final loginControllerProvider = StateNotifierProvider<LoginController, AsyncValue<void>>((ref) => LoginController());
