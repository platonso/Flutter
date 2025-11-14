import 'package:flutter/foundation.dart';
import '../../models/country.dart';

class CountriesService extends ChangeNotifier {
  final List<Country> _countries = [
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
  ];

  List<Country> get countries => List.unmodifiable(_countries);

  void addCountry(Country country) {
    _countries.add(country);
    notifyListeners();
  }

  void toggleVisited(int index) {
    if (index >= 0 && index < _countries.length) {
      _countries[index] = _countries[index].copyWith(
        isVisited: !_countries[index].isVisited,
      );
      notifyListeners();
    }
  }

  void deleteCountry(int index) {
    if (index >= 0 && index < _countries.length) {
      _countries.removeAt(index);
      notifyListeners();
    }
  }
}

