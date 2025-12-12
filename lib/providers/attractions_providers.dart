import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/attraction.dart';
import '../services/data_service.dart';
import 'data_service_provider.dart';

// Провайдер для списка достопримечательностей
final attractionsProvider = StateNotifierProvider<AttractionsNotifier, List<Attraction>>((ref) {
  final dataService = ref.watch(dataServiceProvider);
  return AttractionsNotifier(dataService);
});

class AttractionsNotifier extends StateNotifier<List<Attraction>> {
  final DataService _dataService;

  AttractionsNotifier(this._dataService) : super(_dataService.attractions);

  void addAttraction(Attraction attraction) {
    _dataService.addAttraction(attraction);
    state = List.from(_dataService.attractions);
  }

  void updateAttraction(int index, Attraction attraction) {
    _dataService.updateAttraction(index, attraction);
    state = List.from(_dataService.attractions);
  }

  void deleteAttraction(int index) {
    _dataService.deleteAttraction(index);
    state = List.from(_dataService.attractions);
  }

  void refresh() {
    state = List.from(_dataService.attractions);
  }
}


