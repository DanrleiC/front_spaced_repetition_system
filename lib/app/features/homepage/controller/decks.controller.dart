import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_spaced_repetition_system/app/features/homepage/models/deck.model.dart';
import 'package:front_spaced_repetition_system/app/repository/api_service.repository.dart';
import 'package:front_spaced_repetition_system/app/repository/provider/api_service.provider.dart';

final decksControllerProvider = Provider<DecksController>((ref) {
  final api = ref.read(apiServiceProvider);
  return DecksController(api);
});

final decksProvider = FutureProvider<List<DeckModel>>((ref) async {
  final repo = ref.read(decksControllerProvider);
  return repo.buscarCartoes();
});

class DecksController {
  final ApiService _api;

  DecksController(this._api);

  Future<List<DeckModel>> buscarCartoes() async {
    final response = await _api.get('/decks/getAll?page=1&limit=50');

    if (response is List) {
      return response.map((e) => DeckModel.fromMap(e)).toList();
    } else {
      throw Exception('Erro 4002');
    }
  }
}
