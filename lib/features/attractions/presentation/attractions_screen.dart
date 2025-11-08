import 'package:flutter/cupertino.dart';
import '../../../models/attraction.dart';

class AttractionsScreen extends StatefulWidget {
  final bool showNavigationBar;
  
  const AttractionsScreen({
    super.key,
    this.showNavigationBar = true,
  });

  @override
  State<AttractionsScreen> createState() => _AttractionsScreenState();
}

class _AttractionsScreenState extends State<AttractionsScreen> {
  final List<Attraction> _attractions = [
    const Attraction(
      name: 'Эйфелева башня',
      location: 'Париж, Франция',
      icon: 'Башня',
      description: 'Символ Парижа и Франции, построенная в 1889 году',
      isFavorite: false,
      imageUrl: '',
    ),
    const Attraction(
      name: 'Колизей',
      location: 'Рим, Италия',
      icon: 'Амфитеатр',
      description: 'Древний амфитеатр, символ Римской империи',
      isFavorite: false,
      imageUrl: '',
    ),
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _iconController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  void _addAttraction() {
    if (_nameController.text.isEmpty || _locationController.text.isEmpty) {
      return;
    }
    setState(() {
      _attractions.add(
        Attraction(
          name: _nameController.text,
          location: _locationController.text,
          icon: _iconController.text.isNotEmpty
              ? _iconController.text
              : 'Место',
          description: _descController.text.isNotEmpty
              ? _descController.text
              : 'Описание отсутствует',
          isFavorite: false,
          imageUrl: '',
        ),
      );
    });
    _nameController.clear();
    _locationController.clear();
    _iconController.clear();
    _descController.clear();
  }

  void _toggleFavorite(int index) {
    setState(() {
      _attractions[index] = _attractions[index].copyWith(
        isFavorite: !_attractions[index].isFavorite,
      );
    });
  }

  void _deleteAttraction(int index) {
    setState(() {
      _attractions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: widget.showNavigationBar
          ? const CupertinoNavigationBar(
              middle: Text('Достопримечательности'),
            )
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
                      'Добавить место',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
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
                      placeholder: 'Тип места (напр. Замок)',
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
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: CupertinoColors.systemGrey5,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  CupertinoIcons.location_fill,
                                  color: CupertinoColors.systemOrange,
                                  size: 40,
                                ),
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
