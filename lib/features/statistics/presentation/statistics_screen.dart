import 'package:flutter/cupertino.dart';

class StatisticsScreen extends StatelessWidget {
  final bool showNavigationBar;

  const StatisticsScreen({
    super.key,
    this.showNavigationBar = true,
  });

  @override
  Widget build(BuildContext context) {
    // Простые данные для статистики
    final int totalCountries = 3;
    final int totalAttractions = 2;
    final int totalTrips = 1;
    final int visitedCountries = 1;
    final int favoriteAttractions = 1;
    final int completedTrips = 0;

    return CupertinoPageScaffold(
      navigationBar: showNavigationBar
          ? const CupertinoNavigationBar(middle: Text('Статистика'))
          : null,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Статистика путешествий',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              _buildStatCard(
                'Всего стран',
                totalCountries.toString(),
                CupertinoIcons.globe,
                CupertinoColors.activeBlue,
              ),
              const SizedBox(height: 16),
              _buildStatCard(
                'Посещено стран',
                visitedCountries.toString(),
                CupertinoIcons.checkmark_circle_fill,
                CupertinoColors.systemGreen,
              ),
              const SizedBox(height: 16),
              _buildStatCard(
                'Всего достопримечательностей',
                totalAttractions.toString(),
                CupertinoIcons.location_fill,
                CupertinoColors.systemOrange,
              ),
              const SizedBox(height: 16),
              _buildStatCard(
                'Избранных мест',
                favoriteAttractions.toString(),
                CupertinoIcons.heart_fill,
                CupertinoColors.systemRed,
              ),
              const SizedBox(height: 16),
              _buildStatCard(
                'Всего поездок',
                totalTrips.toString(),
                CupertinoIcons.calendar,
                CupertinoColors.systemPurple,
              ),
              const SizedBox(height: 16),
              _buildStatCard(
                'Завершено поездок',
                completedTrips.toString(),
                CupertinoIcons.check_mark,
                CupertinoColors.systemTeal,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: color,
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
                    fontSize: 14,
                    color: CupertinoColors.secondaryLabel,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
