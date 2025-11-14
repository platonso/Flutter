import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../../models/attraction.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/services/attractions_service.dart';

class AttractionsScreen extends StatefulWidget {
  const AttractionsScreen({super.key});

  @override
  State<AttractionsScreen> createState() => _AttractionsScreenState();
}

class _AttractionsScreenState extends State<AttractionsScreen> {
  // Получаем сервис через GetIt
  late final AttractionsService _attractionsService = getIt<AttractionsService>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _iconController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Подписываемся на изменения в сервисе
    _attractionsService.addListener(_onAttractionsChanged);
  }

  @override
  void dispose() {
    // Отписываемся от изменений
    _attractionsService.removeListener(_onAttractionsChanged);
    _nameController.dispose();
    _locationController.dispose();
    _iconController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _onAttractionsChanged() {
    // Обновляем UI при изменениях в сервисе
    setState(() {});
  }

  void _addAttraction() {
    if (_nameController.text.isEmpty || _locationController.text.isEmpty) return;
    // Используем сервис из GetIt для добавления достопримечательности
    _attractionsService.addAttraction(Attraction(
      name: _nameController.text,
      location: _locationController.text,
      icon: _iconController.text.isNotEmpty ? _iconController.text : '📍',
      description: _descController.text.isNotEmpty ? _descController.text : 'Описание отсутствует',
      isFavorite: false,
    ));
    _nameController.clear();
    _locationController.clear();
    _iconController.clear();
    _descController.clear();
  }

  void _toggleFavorite(int index) {
    // Используем сервис из GetIt для изменения статуса избранного
    _attractionsService.toggleFavorite(index);
  }

  void _deleteAttraction(int index) {
    // Используем сервис из GetIt для удаления достопримечательности
    _attractionsService.deleteAttraction(index);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Достопримечательности'),
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
                      'Добавить место',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 12),
                    CupertinoTextField(
                      controller: _nameController,
                      placeholder: 'Название',
                      padding: const EdgeInsets.all(12),
                    ),
                    const SizedBox(height: 8),
                    CupertinoTextField(
                      controller: _locationController,
                      placeholder: 'Локация',
                      padding: const EdgeInsets.all(12),
                    ),
                    const SizedBox(height: 8),
                    CupertinoTextField(
                      controller: _iconController,
                      placeholder: 'Иконка (эмодзи, напр. 🏰)',
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
                      onPressed: _addAttraction,
                      child: const Text('Добавить место'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _attractionsService.attractions.length,
                  itemBuilder: (context, index) {
                    final attraction = _attractionsService.attractions[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => _toggleFavorite(index),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: attraction.isFavorite
                                ? CupertinoColors.systemOrange.withOpacity(0.1)
                                : CupertinoColors.systemGrey6,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: attraction.isFavorite
                                  ? CupertinoColors.systemOrange
                                  : CupertinoColors.systemGrey4,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                attraction.icon,
                                style: const TextStyle(fontSize: 32),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      attraction.name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: CupertinoColors.label,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      attraction.location,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: CupertinoColors.secondaryLabel,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      attraction.description,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: CupertinoColors.tertiaryLabel,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                attraction.isFavorite
                                    ? CupertinoIcons.heart_fill
                                    : CupertinoIcons.heart,
                                color: attraction.isFavorite
                                    ? CupertinoColors.systemRed
                                    : CupertinoColors.systemGrey,
                                size: 24,
                              ),
                              const SizedBox(width: 4),
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () => _deleteAttraction(index),
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


