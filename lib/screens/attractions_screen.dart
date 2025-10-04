import 'package:flutter/cupertino.dart';

class AttractionsScreen extends StatefulWidget {
  const AttractionsScreen({super.key});

  @override
  State<AttractionsScreen> createState() => _AttractionsScreenState();
}

class _AttractionsScreenState extends State<AttractionsScreen> {
  final List<Map<String, dynamic>> _attractions = [
    {
      'name': 'Эйфелева башня',
      'location': 'Париж, Франция',
      'icon': '🗼',
      'description': 'Символ Парижа и Франции, построенная в 1889 году',
      'isFavorite': false,
    },
    {
      'name': 'Колизей',
      'location': 'Рим, Италия',
      'icon': '🏛️',
      'description': 'Древний амфитеатр, символ Римской империи',
      'isFavorite': false,
    },
    {
      'name': 'Тадж-Махал',
      'location': 'Агра, Индия',
      'icon': '🕌',
      'description': 'Мавзолей-мечеть, символ вечной любви',
      'isFavorite': false,
    },
    {
      'name': 'Статуя Свободы',
      'location': 'Нью-Йорк, США',
      'icon': '🗽',
      'description': 'Символ свободы и демократии Америки',
      'isFavorite': false,
    },
    {
      'name': 'Пирамиды Гизы',
      'location': 'Каир, Египет',
      'icon': '🔺',
      'description': 'Древние египетские пирамиды, одно из чудес света',
      'isFavorite': false,
    },
    {
      'name': 'Сиднейский оперный театр',
      'location': 'Сидней, Австралия',
      'icon': '🎭',
      'description': 'Архитектурный шедевр и символ Австралии',
      'isFavorite': false,
    },
  ];

  void _toggleFavorite(int index) {
    setState(() {
      _attractions[index]['isFavorite'] = !_attractions[index]['isFavorite'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Достопримечательности'),
      ),
      child: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _attractions.length,
          itemBuilder: (context, index) {
            final attraction = _attractions[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => _toggleFavorite(index),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: attraction['isFavorite'] 
                        ? CupertinoColors.systemOrange.withOpacity(0.1)
                        : CupertinoColors.systemGrey6,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: attraction['isFavorite'] 
                          ? CupertinoColors.systemOrange
                          : CupertinoColors.systemGrey4,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        attraction['icon'],
                        style: const TextStyle(fontSize: 32),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              attraction['name'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: CupertinoColors.label,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              attraction['location'],
                              style: const TextStyle(
                                fontSize: 14,
                                color: CupertinoColors.secondaryLabel,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              attraction['description'],
                              style: const TextStyle(
                                fontSize: 12,
                                color: CupertinoColors.tertiaryLabel,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        attraction['isFavorite'] 
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart,
                        color: attraction['isFavorite'] 
                            ? CupertinoColors.systemRed
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
