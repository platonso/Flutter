import 'package:flutter/cupertino.dart';
import 'countries_screen.dart';
import 'attractions_screen.dart';
import 'planner_screen.dart';
import 'about_screen.dart';
import 'travel_counter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Путешествия'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const TravelCounter(),
              const SizedBox(height: 30),
              const Text(
                'Выберите раздел:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              _buildMenuButton(
                context,
                '🌍 Страны',
                'Изучите разные страны мира',
                () => Navigator.of(context).push(
                  CupertinoPageRoute(builder: (context) => const CountriesScreen()),
                ),
              ),
              const SizedBox(height: 12),
              _buildMenuButton(
                context,
                '🏛️ Достопримечательности',
                'Узнайте о знаменитых местах',
                () => Navigator.of(context).push(
                  CupertinoPageRoute(builder: (context) => const AttractionsScreen()),
                ),
              ),
              const SizedBox(height: 12),
              _buildMenuButton(
                context,
                '📅 Планировщик',
                'Спланируйте свое путешествие',
                () => Navigator.of(context).push(
                  CupertinoPageRoute(builder: (context) => const PlannerScreen()),
                ),
              ),
              const SizedBox(height: 12),
              _buildMenuButton(
                context,
                'ℹ️ О приложении',
                'Информация о приложении',
                () => Navigator.of(context).push(
                  CupertinoPageRoute(builder: (context) => const AboutScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: CupertinoColors.label,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.secondaryLabel,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              CupertinoIcons.chevron_right,
              color: Color.fromRGBO(142, 142, 147, 1),
            ),
          ],
        ),
      ),
    );
  }
}
