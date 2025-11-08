import 'package:flutter/cupertino.dart';
import '../../../models/country.dart';

class CountriesScreen extends StatefulWidget {
  final bool showNavigationBar;

  const CountriesScreen({super.key, this.showNavigationBar = true});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  final List<Country> _countries = [
    const Country(
      name: 'Франция',
      capital: 'Париж',
      description: 'Страна романтики, искусства и изысканной кухни',
      isVisited: false,
      imageUrl: '',
    ),
    const Country(
      name: 'Япония',
      capital: 'Токио',
      description: 'Страна восходящего солнца с богатой культурой',
      isVisited: false,
      imageUrl: '',
    ),
    const Country(
      name: 'Италия',
      capital: 'Рим',
      description: 'Колыбель искусства и архитектуры',
      isVisited: false,
      imageUrl: '',
    ),
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _capitalController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  void _addCountry() {
    if (_nameController.text.isEmpty || _capitalController.text.isEmpty) return;
    setState(() {
      _countries.add(
        Country(
          name: _nameController.text,
          capital: _capitalController.text,
          description: _descController.text.isNotEmpty
              ? _descController.text
              : 'Описание отсутствует',
          isVisited: false,
          imageUrl: '',
        ),
      );
    });
    _nameController.clear();
    _capitalController.clear();
    _descController.clear();
  }

  void _toggleVisited(int index) {
    setState(() {
      _countries[index] = _countries[index].copyWith(
        isVisited: !_countries[index].isVisited,
      );
    });
  }

  void _deleteCountry(int index) {
    setState(() {
      _countries.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: widget.showNavigationBar
          ? const CupertinoNavigationBar(middle: Text('Страны'))
          : null,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Добавить страну',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    CupertinoTextField(
                      controller: _nameController,
                      placeholder: 'Название страны',
                      padding: const EdgeInsets.all(12),
                    ),
                    const SizedBox(height: 8),
                    CupertinoTextField(
                      controller: _capitalController,
                      placeholder: 'Столица',
                      padding: const EdgeInsets.all(12),
                    ),
                    const SizedBox(height: 8),
                    CupertinoTextField(
                      controller: _descController,
                      placeholder: 'Описание (необязательно)',
                      padding: const EdgeInsets.all(12),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 8),
                    const SizedBox(height: 12),
                    CupertinoButton.filled(
                      onPressed: _addCountry,
                      child: const Text('Добавить страну'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _countries.length,
                  itemBuilder: (context, index) {
                    final country = _countries[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: GestureDetector(
                        onLongPress: () => _toggleVisited(index),
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (context) =>
                                    CountryDetailScreen(country: country),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: country.isVisited
                                  ? CupertinoColors.systemGreen.withOpacity(0.1)
                                  : CupertinoColors.systemGrey6,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: country.isVisited
                                    ? CupertinoColors.systemGreen
                                    : CupertinoColors.systemGrey4,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: CupertinoColors.systemGrey5,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    CupertinoIcons.globe,
                                    color: CupertinoColors.systemBlue,
                                    size: 40,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        country.name,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: CupertinoColors.label,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Столица: ${country.capital}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: CupertinoColors.secondaryLabel,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        country.description,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: CupertinoColors.tertiaryLabel,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  country.isVisited
                                      ? CupertinoIcons.checkmark_circle_fill
                                      : CupertinoIcons.circle,
                                  color: country.isVisited
                                      ? CupertinoColors.systemGreen
                                      : CupertinoColors.systemGrey,
                                  size: 24,
                                ),
                                const SizedBox(width: 4),
                                CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () => _deleteCountry(index),
                                  child: const Icon(
                                    CupertinoIcons.trash,
                                    color: CupertinoColors.systemRed,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Детальный экран страны - пример вертикальной навигации внутри раздела
class CountryDetailScreen extends StatelessWidget {
  final Country country;

  const CountryDetailScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Детали страны'),
        leading: CupertinoNavigationBarBackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Text(
                country.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Столица: ${country.capital}',
                style: const TextStyle(
                  fontSize: 18,
                  color: CupertinoColors.secondaryLabel,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  country.description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: CupertinoColors.label,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
