import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/statistics_providers.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countriesCount = ref.watch(countriesCountProvider);
    final visitedCountriesCount = ref.watch(visitedCountriesCountProvider);
    final tripsCount = ref.watch(tripsCountProvider);
    final completedTripsCount = ref.watch(completedTripsCountProvider);
    final attractionsCount = ref.watch(attractionsCountProvider);
    final favoriteAttractionsCount = ref.watch(favoriteAttractionsCountProvider);
    final checklistItemsCount = ref.watch(checklistItemsCountProvider);
    final packedItemsCount = ref.watch(packedItemsCountProvider);

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
              const SizedBox(height: 16),
              _buildStatCard(
                '✅ Чек-лист',
                'Всего вещей',
                checklistItemsCount.toString(),
                'Собрано',
                packedItemsCount.toString(),
                CupertinoColors.systemPurple,
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
                    _buildStatRow('Всего вещей в чек-листе', checklistItemsCount),
                    _buildStatRow('Собрано вещей', packedItemsCount),
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
