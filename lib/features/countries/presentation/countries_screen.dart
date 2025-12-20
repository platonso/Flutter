import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/ui_constants.dart';
import '../../../models/country.dart';
import '../../../providers/countries_providers.dart';

class CountriesScreen extends ConsumerStatefulWidget {
  const CountriesScreen({super.key});

  @override
  ConsumerState<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends ConsumerState<CountriesScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _capitalController = TextEditingController();
  final TextEditingController _flagController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  void _addCountry() {
    if (_nameController.text.isEmpty || _capitalController.text.isEmpty) return;
    ref.read(countriesProvider.notifier).addCountry(Country(
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
    final countries = ref.read(countriesProvider);
    final country = countries[index];
    ref.read(countriesProvider.notifier).updateCountry(index, country.copyWith(
      isVisited: !country.isVisited,
    ));
  }

  void _deleteCountry(int index) {
    ref.read(countriesProvider.notifier).deleteCountry(index);
  }

  @override
  Widget build(BuildContext context) {
    final countries = ref.watch(countriesProvider);
    
    return CupertinoPageScaffold(
      backgroundColor: AppColors.background,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Страны'),
        backgroundColor: AppColors.surface,
        border: null,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Text(
                'Ваши страны',
                style: AppStyles.headerTitle,
              ),
              const SizedBox(height: 8),
              Text(
                'Отмечайте места, где вы уже побывали',
                style: AppStyles.cardSubtitle,
              ),
              const SizedBox(height: 24),

              // Form
              Container(
                padding: const EdgeInsets.all(20),
                decoration: AppStyles.cardDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Добавить новую страну', style: AppStyles.cardTitle),
                    const SizedBox(height: 16),
                    _buildInput(_nameController, 'Название страны'),
                    const SizedBox(height: 12),
                    _buildInput(_capitalController, 'Столица'),
                    const SizedBox(height: 12),
                    _buildInput(_flagController, 'Флаг (эмодзи)'),
                    const SizedBox(height: 12),
                    _buildInput(_descController, 'Описание', maxLines: 2),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: CupertinoButton.filled(
                        onPressed: _addCountry,
                        child: const Text('Добавить'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // List
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: countries.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final country = countries[index];
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: AppStyles.cardDecoration,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(country.flag, style: const TextStyle(fontSize: 40)),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      country.name,
                                      style: AppStyles.cardTitle,
                                    ),
                                  ),
                                  if (country.isVisited)
                                    const Icon(
                                      CupertinoIcons.checkmark_seal_fill,
                                      color: AppColors.primary,
                                      size: 20,
                                    ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(country.capital, style: AppStyles.cardSubtitle),
                              const SizedBox(height: 8),
                              Text(
                                country.description,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textMain,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    minSize: 0,
                                    onPressed: () => _toggleVisited(index),
                                    child: Text(
                                      country.isVisited ? 'Не был' : 'Посетил',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: country.isVisited 
                                            ? CupertinoColors.systemRed 
                                            : AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size.zero,
                                    onPressed: () => _deleteCountry(index),
                                    child: const Text(
                                      'Удалить',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: CupertinoColors.systemGrey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(
    TextEditingController controller, 
    String placeholder, 
    {int maxLines = 1}
  ) {
    return CupertinoTextField(
      controller: controller,
      placeholder: placeholder,
      padding: const EdgeInsets.all(14),
      maxLines: maxLines,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: CupertinoColors.systemGrey5),
      ),
      style: const TextStyle(fontSize: 15),
    );
  }
}
