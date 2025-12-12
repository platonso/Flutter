import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/trip.dart';
import '../services/data_service.dart';
import 'data_service_provider.dart';

// Провайдер для списка поездок
final tripsProvider = StateNotifierProvider<TripsNotifier, List<Trip>>((ref) {
  final dataService = ref.watch(dataServiceProvider);
  return TripsNotifier(dataService);
});

class TripsNotifier extends StateNotifier<List<Trip>> {
  final DataService _dataService;

  TripsNotifier(this._dataService) : super(_dataService.trips);

  void addTrip(Trip trip) {
    _dataService.addTrip(trip);
    state = List.from(_dataService.trips);
  }

  void updateTrip(int index, Trip trip) {
    _dataService.updateTrip(index, trip);
    state = List.from(_dataService.trips);
  }

  void deleteTrip(int index) {
    _dataService.deleteTrip(index);
    state = List.from(_dataService.trips);
  }

  void refresh() {
    state = List.from(_dataService.trips);
  }
}


