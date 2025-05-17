// providers.dart
import 'package:front_spaced_repetition_system/app/features/user/controller/user.controller.dart';
import 'package:riverpod/riverpod.dart';

final userControllerProvider = StateNotifierProvider<UserController, AsyncValue<void>>((ref) => UserController());
