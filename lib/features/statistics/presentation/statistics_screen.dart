import 'package:flutter/cupertino.dart';
import '../../../services/data_service.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  final DataService _dataService = DataService();

  @override
  void initState() {
    super.initState();
    _dataService.initializeDefaultData();
  }

  @override
  Widget build(BuildContext context) {
    final countriesCount = _dataService.countriesCount;
    final visitedCountriesCount = _dataService.visitedCountriesCount;
    final tripsCount = _dataService.tripsCount;
    final completedTripsCount = _dataService.completedTripsCount;
    final attractionsCount = _dataService.attractionsCount;
    final favoriteAttractionsCount = _dataService.favoriteAttractionsCount;

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Статистика')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              _buildStatCard(
                '🌍 Страны',
                'Всего стран',
                countriesCount.toString(),
                'Посещено',
                visitedCountriesCount.toString(),
                CupertinoColors.systemBlue,
              ),
              const SizedBox(height: 16),
              _buildStatCard(
                '📅 Планы',
                'Всего планов',
                tripsCount.toString(),
                'Завершено',
                completedTripsCount.toString(),
                CupertinoColors.systemGreen,
              ),
              const SizedBox(height: 16),
              _buildStatCard(
                '🏛️ Достопримечательности',
                'Всего мест',
                attractionsCount.toString(),
                'В избранном',
                favoriteAttractionsCount.toString(),
                CupertinoColors.systemOrange,
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Общая статистика',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: CupertinoColors.label,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildStatRow('Всего стран', countriesCount),
                    _buildStatRow('Посещено стран', visitedCountriesCount),
                    _buildStatRow('Всего планов', tripsCount),
                    _buildStatRow('Завершено планов', completedTripsCount),
                    _buildStatRow(
                      'Всего достопримечательностей',
                      attractionsCount,
                    ),
                    _buildStatRow('В избранном', favoriteAttractionsCount),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String icon,
    String title1,
    String value1,
    String title2,
    String value2,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      value1,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      title1,
                      style: const TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.secondaryLabel,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Container(width: 1, height: 50, color: color.withOpacity(0.3)),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      value2,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      title2,
                      style: const TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.secondaryLabel,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: CupertinoColors.label),
          ),
          Text(
            value.toString(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: CupertinoColors.activeBlue,
            ),
          ),
        ],
      ),
    );
  }
}
