import 'package:flutter/cupertino.dart';
import 'features/navigation/presentation/page_view_navigation_screen.dart';
import 'features/countries/presentation/countries_screen.dart';
import 'features/attractions/presentation/attractions_screen.dart';
import 'features/planner/presentation/planner_screen.dart';
import 'features/statistics/presentation/statistics_screen.dart';

void main() {
  runApp(const TravelApp());
}

class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Путешествия',
      theme: const CupertinoThemeData(
        primaryColor: CupertinoColors.activeBlue,
        scaffoldBackgroundColor: CupertinoColors.systemBackground,
      ),
      // Используем PageView навигацию как главный экран
      home: const PageViewNavigationScreen(),
      // Настройка маршрутов для маршрутизированной навигации
      routes: {
        '/home': (context) => const PageViewNavigationScreen(),
        '/countries': (context) => TabNavigationScreen(
          screenIndex: 1,
          child: const CountriesScreen(showNavigationBar: false),
        ),
        '/attractions': (context) => TabNavigationScreen(
          screenIndex: 2,
          child: const AttractionsScreen(showNavigationBar: false),
        ),
        '/planner': (context) => TabNavigationScreen(
          screenIndex: 3,
          child: const PlannerScreen(showNavigationBar: false),
        ),
        '/statistics': (context) => TabNavigationScreen(
          screenIndex: 4,
          child: const StatisticsScreen(showNavigationBar: false),
        ),
      },
    );
  }
}
