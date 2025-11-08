import 'package:flutter/cupertino.dart';
import '../../home/presentation/home_screen.dart';
import '../../countries/presentation/countries_screen.dart';
import '../../attractions/presentation/attractions_screen.dart';
import '../../planner/presentation/planner_screen.dart';
import '../../statistics/presentation/statistics_screen.dart';

class PageViewNavigationScreen extends StatefulWidget {
  const PageViewNavigationScreen({super.key});

  @override
  State<PageViewNavigationScreen> createState() =>
      _PageViewNavigationScreenState();
}

class _PageViewNavigationScreenState extends State<PageViewNavigationScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Используем версии экранов без NavigationBar для PageView
  List<Widget> get _pages => [
    const HomeScreenContent(),
    const CountriesScreenContent(),
    const AttractionsScreenContent(),
    const PlannerScreenContent(),
    const StatisticsScreenContent(),
  ];

  final List<String> _pageTitles = const [
    'Главная',
    'Страны',
    'Места',
    'Планировщик',
    'Статистика',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

    // Маршруты из маршрутной карты для горизонтальной навигации
  final List<String> _routes = const [
    '/home',
    '/countries',
    '/attractions',
    '/planner',
    '/statistics',
  ];

  void _onTabTapped(int index) {
    if (index != _currentPage) {
      Navigator.of(context).pushReplacementNamed(_routes[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(_pageTitles[_currentPage]),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: _pages,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: CupertinoColors.systemBackground,
                border: Border(
                  top: BorderSide(color: CupertinoColors.separator, width: 0.5),
                ),
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    _pages.length,
                    (index) => Expanded(
                      child: CupertinoButton(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        onPressed: () => _onTabTapped(index),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _getIconForIndex(index),
                              color: _currentPage == index
                                  ? CupertinoColors.activeBlue
                                  : CupertinoColors.systemGrey,
                              size: 24,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _pageTitles[index],
                              style: TextStyle(
                                fontSize: 12,
                                color: _currentPage == index
                                    ? CupertinoColors.activeBlue
                                    : CupertinoColors.systemGrey,
                                fontWeight: _currentPage == index
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return CupertinoIcons.house_fill;
      case 1:
        return CupertinoIcons.globe;
      case 2:
        return CupertinoIcons.location_fill;
      case 3:
        return CupertinoIcons.calendar;
      case 4:
        return CupertinoIcons.chart_bar_fill;
      default:
        return CupertinoIcons.circle;
    }
  }
}

// Виджеты-обертки для экранов без NavigationBar для использования в PageView

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreen(showNavigationBar: false);
  }
}

class CountriesScreenContent extends StatelessWidget {
  const CountriesScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const CountriesScreen(showNavigationBar: false);
  }
}

class AttractionsScreenContent extends StatelessWidget {
  const AttractionsScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const AttractionsScreen(showNavigationBar: false);
  }
}

class PlannerScreenContent extends StatelessWidget {
  const PlannerScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlannerScreen(showNavigationBar: false);
  }
}

class StatisticsScreenContent extends StatelessWidget {
  const StatisticsScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const StatisticsScreen(showNavigationBar: false);
  }
}

// Экран с нижней панелью навигации для использования с pushReplacement
class TabNavigationScreen extends StatelessWidget {
  final int screenIndex;
  final Widget child;

  const TabNavigationScreen({
    super.key,
    required this.screenIndex,
    required this.child,
  });

  final List<String> _pageTitles = const [
    'Главная',
    'Страны',
    'Места',
    'Планировщик',
    'Статистика',
  ];

  // Маршруты из маршрутной карты для горизонтальной навигации
  final List<String> _routes = const [
    '/home',
    '/countries',
    '/attractions',
    '/planner',
    '/statistics',
  ];

  void _onTabTapped(int index, BuildContext context) {
    // Горизонтальная навигация: используем pushReplacementNamed с маршрутами из маршрутной карты
    if (index != screenIndex) {
      // Используем именованные маршруты из маршрутной карты
      Navigator.of(context).pushReplacementNamed(_routes[index]);
    }
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return CupertinoIcons.house_fill;
      case 1:
        return CupertinoIcons.globe;
      case 2:
        return CupertinoIcons.location_fill;
      case 3:
        return CupertinoIcons.calendar;
      case 4:
        return CupertinoIcons.chart_bar_fill;
      default:
        return CupertinoIcons.circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(_pageTitles[screenIndex]),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(child: child),
            Container(
              decoration: BoxDecoration(
                color: CupertinoColors.systemBackground,
                border: Border(
                  top: BorderSide(
                    color: CupertinoColors.separator,
                    width: 0.5,
                  ),
                ),
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    5,
                    (index) => Expanded(
                      child: CupertinoButton(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        onPressed: () => _onTabTapped(index, context),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _getIconForIndex(index),
                              color: screenIndex == index
                                  ? CupertinoColors.activeBlue
                                  : CupertinoColors.systemGrey,
                              size: 24,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _pageTitles[index],
                              style: TextStyle(
                                fontSize: 12,
                                color: screenIndex == index
                                    ? CupertinoColors.activeBlue
                                    : CupertinoColors.systemGrey,
                                fontWeight: screenIndex == index
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
