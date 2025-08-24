import 'package:front_spaced_repetition_system/app/features/card/models/flash_card.dart';
import 'package:front_spaced_repetition_system/app/repository/api_service.repository.dart';
import 'package:front_spaced_repetition_system/app/repository/provider/api_service.provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final flashcardsControllerProvider = Provider<FlashcardsControllerApi>((ref) {
  final api = ref.watch(apiServiceProvider);
  return FlashcardsControllerApi(api);
});

class FlashcardsControllerApi {
  final ApiService _api;

  FlashcardsControllerApi(this._api);

  Future<List<Flashcard>> getAllCards(String deckId) async {
    final data = await _api.get('/cards/getAll', queryParameters: {'deckId': deckId});
    if (data is List) {
      return data.map((json) => Flashcard.fromJson(json)).toList();
    }
    return [];
  }
}