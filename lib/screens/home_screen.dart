import 'package:flutter/cupertino.dart';
import 'countries_column_screen.dart';
import 'attractions_listview_screen.dart';
import 'travel_plans_listview_separated_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Путешествия')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSimpleMenuButton(
                context,
                '📋 Страны',
                () => Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => const CountriesColumnScreen(),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _buildSimpleMenuButton(
                context,
                '🏛️ Достопримечательности',
                () => Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => const AttractionsListViewScreen(),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _buildSimpleMenuButton(
                context,
                '✈️ Планы путешествий',
                () => Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) =>
                        const TravelPlansListViewSeparatedScreen(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSimpleMenuButton(
    BuildContext context,
    String title,
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
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: CupertinoColors.label,
                ),
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
