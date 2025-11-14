import 'package:get_it/get_it.dart';
import '../services/countries_service.dart';
import '../services/attractions_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<CountriesService>(() => CountriesService());
  getIt.registerLazySingleton<AttractionsService>(() => AttractionsService());
}

