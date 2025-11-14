import '../models/country.dart';
import '../models/trip.dart';
import '../models/attraction.dart';

class DataService {
  static final DataService _instance = DataService._internal();
  factory DataService() => _instance;
  DataService._internal();

  final List<Country> _countries = [];
  final List<Trip> _trips = [];
  final List<Attraction> _attractions = [];

  // Countries
  List<Country> get countries => List.unmodifiable(_countries);
  int get countriesCount => _countries.length;
  int get visitedCountriesCount => _countries.where((c) => c.isVisited).length;

  void addCountry(Country country) {
    _countries.add(country);
  }

  void updateCountry(int index, Country country) {
    if (index >= 0 && index < _countries.length) {
      _countries[index] = country;
    }
  }

  void deleteCountry(int index) {
    if (index >= 0 && index < _countries.length) {
      _countries.removeAt(index);
    }
  }

  // Trips
  List<Trip> get trips => List.unmodifiable(_trips);
  int get tripsCount => _trips.length;
  int get completedTripsCount => _trips.where((t) => t.isCompleted).length;

  void addTrip(Trip trip) {
    _trips.add(trip);
  }

  void updateTrip(int index, Trip trip) {
    if (index >= 0 && index < _trips.length) {
      _trips[index] = trip;
    }
  }

  void deleteTrip(int index) {
    if (index >= 0 && index < _trips.length) {
      _trips.removeAt(index);
    }
  }

  // Attractions
  List<Attraction> get attractions => List.unmodifiable(_attractions);
  int get attractionsCount => _attractions.length;
  int get favoriteAttractionsCount => _attractions.where((a) => a.isFavorite).length;

  void addAttraction(Attraction attraction) {
    _attractions.add(attraction);
  }

  void updateAttraction(int index, Attraction attraction) {
    if (index >= 0 && index < _attractions.length) {
      _attractions[index] = attraction;
    }
  }

  void deleteAttraction(int index) {
    if (index >= 0 && index < _attractions.length) {
      _attractions.removeAt(index);
    }
  }

  // Initialize with default data
  void initializeDefaultData() {
    if (_countries.isEmpty) {
      _countries.addAll([
        const Country(
          name: 'Франция',
          capital: 'Париж',
          flag: '🇫🇷',
          description: 'Страна романтики, искусства и изысканной кухни',
          isVisited: false,
        ),
        const Country(
          name: 'Япония',
          capital: 'Токио',
          flag: '🇯🇵',
          description: 'Страна восходящего солнца с богатой культурой',
          isVisited: false,
        ),
      ]);
    }

    if (_attractions.isEmpty) {
      _attractions.addAll([
        const Attraction(
          name: 'Эйфелева башня',
          location: 'Париж, Франция',
          icon: '🗼',
          description: 'Символ Парижа и Франции, построенная в 1889 году',
          isFavorite: false,
        ),
        const Attraction(
          name: 'Колизей',
          location: 'Рим, Италия',
          icon: '🏛️',
          description: 'Древний амфитеатр, символ Римской империи',
          isFavorite: false,
        ),
      ]);
    }
  }
}

