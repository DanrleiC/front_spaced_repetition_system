import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_spaced_repetition_system/app/repository/api_service.repository.dart';

final authTokenProvider = StateProvider<String?>((ref) => null);

final apiServiceProvider = Provider<ApiService>((ref) {
  final token = ref.watch(authTokenProvider);
  return ApiService(
    defaultHeaders: {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    },
  );
});