import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/country.dart';
import '../services/data_service.dart';
import 'data_service_provider.dart';

// Провайдер для списка стран
final countriesProvider = StateNotifierProvider<CountriesNotifier, List<Country>>((ref) {
  final dataService = ref.watch(dataServiceProvider);
  return CountriesNotifier(dataService);
});

class CountriesNotifier extends StateNotifier<List<Country>> {
  final DataService _dataService;

  CountriesNotifier(this._dataService) : super(_dataService.countries);

  void addCountry(Country country) {
    _dataService.addCountry(country);
    state = List.from(_dataService.countries);
  }

  void updateCountry(int index, Country country) {
    _dataService.updateCountry(index, country);
    state = List.from(_dataService.countries);
  }

  void deleteCountry(int index) {
    _dataService.deleteCountry(index);
    state = List.from(_dataService.countries);
  }

  void refresh() {
    state = List.from(_dataService.countries);
  }
}


