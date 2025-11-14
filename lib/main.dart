import 'package:flutter/cupertino.dart';
import 'features/home/presentation/home_screen.dart';
import 'core/di/service_locator.dart';
import 'core/providers/trips_provider_state.dart';

void main() {
  setupServiceLocator();
  runApp(const TravelApp());
}

class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return TripsProviderState(
      child: CupertinoApp(
        title: 'Путешествия',
        theme: const CupertinoThemeData(
          primaryColor: CupertinoColors.activeBlue,
          scaffoldBackgroundColor: CupertinoColors.systemBackground,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}