import 'package:flutter/cupertino.dart';
import '../../models/trip.dart';
import 'trips_provider.dart';

class TripsProviderState extends StatefulWidget {
  final Widget child;

  const TripsProviderState({
    super.key,
    required this.child,
  });

  @override
  State<TripsProviderState> createState() => _TripsProviderStateState();
}

class _TripsProviderStateState extends State<TripsProviderState> {
  final List<Trip> _trips = [];

  void _addTrip(Trip trip) {
    setState(() {
      _trips.add(trip);
    });
  }

  void _toggleCompleted(int index) {
    setState(() {
      if (index >= 0 && index < _trips.length) {
        _trips[index] = _trips[index].copyWith(
          isCompleted: !_trips[index].isCompleted,
        );
      }
    });
  }

  void _deleteTrip(int index) {
    setState(() {
      if (index >= 0 && index < _trips.length) {
        _trips.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TripsProvider(
      trips: _trips,
      addTrip: _addTrip,
      toggleCompleted: _toggleCompleted,
      deleteTrip: _deleteTrip,
      child: widget.child,
    );
  }
}

