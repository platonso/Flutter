import 'package:flutter/cupertino.dart';
import '../../models/trip.dart';

class TripsProvider extends InheritedWidget {
  final List<Trip> trips;
  final Function(Trip) addTrip;
  final Function(int) toggleCompleted;
  final Function(int) deleteTrip;

  const TripsProvider({
    super.key,
    required super.child,
    required this.trips,
    required this.addTrip,
    required this.toggleCompleted,
    required this.deleteTrip,
  });

  static TripsProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TripsProvider>();
  }

  static TripsProvider? maybeOf(BuildContext context) {
    final inheritedElement = context.getElementForInheritedWidgetOfExactType<TripsProvider>();
    return inheritedElement?.widget as TripsProvider?;
  }

  @override
  bool updateShouldNotify(TripsProvider oldWidget) {
    // Проверяем изменения в списке: длину и каждый элемент
    if (trips.length != oldWidget.trips.length) {
      return true;
    }
    // Проверяем, изменился ли какой-либо элемент
    for (int i = 0; i < trips.length; i++) {
      if (trips[i] != oldWidget.trips[i]) {
        return true;
      }
    }
    return false;
  }
}

