import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../../models/country.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/services/countries_service.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  // Получаем сервис через GetIt
  late final CountriesService _countriesService = getIt<CountriesService>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _capitalController = TextEditingController();
  final TextEditingController _flagController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Подписываемся на изменения в сервисе
    _countriesService.addListener(_onCountriesChanged);
  }

  @override
  void dispose() {
    // Отписываемся от изменений
    _countriesService.removeListener(_onCountriesChanged);
    _nameController.dispose();
    _capitalController.dispose();
    _flagController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _onCountriesChanged() {
    // Обновляем UI при изменениях в сервисе
    setState(() {});
  }

  void _addCountry() {
    if (_nameController.text.isEmpty || _capitalController.text.isEmpty) return;
    // Используем сервис из GetIt для добавления страны
    _countriesService.addCountry(Country(
      name: _nameController.text,
      capital: _capitalController.text,
      flag: _flagController.text.isNotEmpty ? _flagController.text : '🏳️',
      description: _descController.text.isNotEmpty ? _descController.text : 'Описание отсутствует',
      isVisited: false,
    ));
    _nameController.clear();
    _capitalController.clear();
    _flagController.clear();
    _descController.clear();
  }

  void _toggleVisited(int index) {
    // Используем сервис из GetIt для изменения статуса посещения
    _countriesService.toggleVisited(index);
  }

  void _deleteCountry(int index) {
    // Используем сервис из GetIt для удаления страны
    _countriesService.deleteCountry(index);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Страны'),
      ),
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
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                      controller: _flagController,
                      placeholder: 'Флаг (эмодзи, напр. 🇷🇺)',
                      padding: const EdgeInsets.all(12),
                    ),
                    const SizedBox(height: 8),
                    CupertinoTextField(
                      controller: _descController,
                      placeholder: 'Описание (необязательно)',
                      padding: const EdgeInsets.all(12),
                      maxLines: 2,
                    ),
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
                  itemCount: _countriesService.countries.length,
                  itemBuilder: (context, index) {
                    final country = _countriesService.countries[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => _toggleVisited(index),
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
                              Text(
                                country.flag,
                                style: const TextStyle(fontSize: 32),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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


