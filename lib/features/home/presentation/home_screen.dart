import 'package:flutter/cupertino.dart';

class HomeScreen extends StatelessWidget {
  final bool showNavigationBar;

  const HomeScreen({super.key, this.showNavigationBar = true});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: showNavigationBar
          ? const CupertinoNavigationBar(middle: Text('Путешествия'))
          : null,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Выберите раздел',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              _buildNavigationButton(
                context,
                'Страны',
                'Изучите разные страны мира',
                CupertinoIcons.globe,
                () => Navigator.of(context).pushNamed('/countries'),
                isRouted: true,
              ),
              const SizedBox(height: 12),
              _buildNavigationButton(
                context,
                'Достопримечательности',
                'Узнайте о знаменитых местах',
                CupertinoIcons.location_fill,
                () => Navigator.of(context).pushNamed('/attractions'),
                isRouted: true,
              ),
              const SizedBox(height: 12),
              _buildNavigationButton(
                context,
                'Планировщик',
                'Спланируйте свое путешествие',
                CupertinoIcons.calendar,
                () => Navigator.of(context).pushNamed('/planner'),
                isRouted: true,
              ),
              const SizedBox(height: 12),
              _buildNavigationButton(
                context,
                'Статистика',
                'Просмотр статистики путешествий',
                CupertinoIcons.chart_bar_fill,
                () => Navigator.of(context).pushNamed('/statistics'),
                isRouted: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButton(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool isRouted = false,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isRouted
              ? CupertinoColors.systemOrange.withOpacity(0.1)
              : CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(12),
          border: isRouted
              ? Border.all(
                  color: CupertinoColors.systemOrange.withOpacity(0.3),
                  width: 1,
                )
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isRouted
                    ? CupertinoColors.systemOrange.withOpacity(0.2)
                    : CupertinoColors.activeBlue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: isRouted
                    ? CupertinoColors.systemOrange
                    : CupertinoColors.activeBlue,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
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


