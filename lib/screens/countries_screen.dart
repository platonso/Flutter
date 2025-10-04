import 'package:flutter/cupertino.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  final List<Map<String, dynamic>> _countries = [
    {
      'name': 'Франция',
      'capital': 'Париж',
      'flag': '🇫🇷',
      'description': 'Страна романтики, искусства и изысканной кухни',
      'isVisited': false,
    },
    {
      'name': 'Япония',
      'capital': 'Токио',
      'flag': '🇯🇵',
      'description': 'Страна восходящего солнца с богатой культурой',
      'isVisited': false,
    },
    {
      'name': 'Италия',
      'capital': 'Рим',
      'flag': '🇮🇹',
      'description': 'Колыбель искусства и родина пиццы',
      'isVisited': false,
    },
    {
      'name': 'Испания',
      'capital': 'Мадрид',
      'flag': '🇪🇸',
      'description': 'Страна фламенко, корриды и солнечных пляжей',
      'isVisited': false,
    },
    {
      'name': 'Германия',
      'capital': 'Берлин',
      'flag': '🇩🇪',
      'description': 'Страна пива, замков и автомобилей',
      'isVisited': false,
    },
  ];

  void _toggleVisited(int index) {
    setState(() {
      _countries[index]['isVisited'] = !_countries[index]['isVisited'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Страны'),
      ),
      child: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _countries.length,
          itemBuilder: (context, index) {
            final country = _countries[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => _toggleVisited(index),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: country['isVisited'] 
                        ? CupertinoColors.systemGreen.withOpacity(0.1)
                        : CupertinoColors.systemGrey6,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: country['isVisited'] 
                          ? CupertinoColors.systemGreen
                          : CupertinoColors.systemGrey4,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        country['flag'],
                        style: const TextStyle(fontSize: 32),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              country['name'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: CupertinoColors.label,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Столица: ${country['capital']}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: CupertinoColors.secondaryLabel,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              country['description'],
                              style: const TextStyle(
                                fontSize: 12,
                                color: CupertinoColors.tertiaryLabel,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        country['isVisited'] 
                            ? CupertinoIcons.checkmark_circle_fill
                            : CupertinoIcons.circle,
                        color: country['isVisited'] 
                            ? CupertinoColors.systemGreen
                            : CupertinoColors.systemGrey,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
