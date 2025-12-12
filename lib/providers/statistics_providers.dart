import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'countries_providers.dart';
import 'trips_providers.dart';
import 'attractions_providers.dart';
import 'checklist_providers.dart';

// Провайдеры для статистики
final countriesCountProvider = Provider<int>((ref) {
  final countries = ref.watch(countriesProvider);
  return countries.length;
});

final visitedCountriesCountProvider = Provider<int>((ref) {
  final countries = ref.watch(countriesProvider);
  return countries.where((c) => c.isVisited).length;
});

final tripsCountProvider = Provider<int>((ref) {
  final trips = ref.watch(tripsProvider);
  return trips.length;
});

final completedTripsCountProvider = Provider<int>((ref) {
  final trips = ref.watch(tripsProvider);
  return trips.where((t) => t.isCompleted).length;
});

final attractionsCountProvider = Provider<int>((ref) {
  final attractions = ref.watch(attractionsProvider);
  return attractions.length;
});

final favoriteAttractionsCountProvider = Provider<int>((ref) {
  final attractions = ref.watch(attractionsProvider);
  return attractions.where((a) => a.isFavorite).length;
});

final checklistItemsCountProvider = Provider<int>((ref) {
  final items = ref.watch(checklistProvider);
  return items.length;
});

final packedItemsCountProvider = Provider<int>((ref) {
  final items = ref.watch(checklistProvider);
  return items.where((item) => item.isPacked).length;
});

