import 'package:flutter/foundation.dart';
import '../../models/attraction.dart';

class AttractionsService extends ChangeNotifier {
  final List<Attraction> _attractions = [
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
  ];

  List<Attraction> get attractions => List.unmodifiable(_attractions);

  void addAttraction(Attraction attraction) {
    _attractions.add(attraction);
    notifyListeners();
  }

  void toggleFavorite(int index) {
    if (index >= 0 && index < _attractions.length) {
      _attractions[index] = _attractions[index].copyWith(
        isFavorite: !_attractions[index].isFavorite,
      );
      notifyListeners();
    }
  }

  void deleteAttraction(int index) {
    if (index >= 0 && index < _attractions.length) {
      _attractions.removeAt(index);
      notifyListeners();
    }
  }
}

