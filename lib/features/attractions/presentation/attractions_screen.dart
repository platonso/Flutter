import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../models/attraction.dart';

class AttractionsScreen extends StatefulWidget {
  const AttractionsScreen({super.key});

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
      imageUrl:
          'https://i.pinimg.com/736x/20/5a/82/205a82adac90cbbead16ed8cefbd3cbb.jpg',
    ),
    const Attraction(
      name: 'Колизей',
      location: 'Рим, Италия',
      icon: 'Амфитеатр',
      description: 'Древний амфитеатр, символ Римской империи',
      isFavorite: false,
      imageUrl:
          'https://i.pinimg.com/originals/67/71/be/6771bec00b3f69cf5395c3024e56cc77.jpg',
    ),
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _iconController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  void _addAttraction() {
    if (_nameController.text.isEmpty || _locationController.text.isEmpty)
      return;
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
          imageUrl: _imageUrlController.text.isNotEmpty
              ? _imageUrlController.text
              : 'https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=400',
        ),
      );
    });
    _nameController.clear();
    _locationController.clear();
    _iconController.clear();
    _descController.clear();
    _imageUrlController.clear();
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
                    const SizedBox(height: 8),
                    CupertinoTextField(
                      controller: _imageUrlController,
                      placeholder: 'URL изображения (необязательно)',
                      padding: const EdgeInsets.all(12),
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
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: attraction.imageUrl,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    width: 80,
                                    height: 80,
                                    color: CupertinoColors.systemGrey5,
                                    child: const Icon(
                                      CupertinoIcons.photo,
                                      color: CupertinoColors.systemGrey,
                                      size: 32,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                        width: 80,
                                        height: 80,
                                        color: CupertinoColors.systemGrey5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              attraction.icon,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const Icon(
                                              CupertinoIcons
                                                  .exclamationmark_triangle,
                                              color: CupertinoColors.systemRed,
                                              size: 16,
                                            ),
                                          ],
                                        ),
                                      ),
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
