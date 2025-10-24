import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../models/country.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

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
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/2/27/Flag_colors_of_France_-Template.svg/1200px-Flag_colors_of_France_-Template.svg.png',
    ),
    const Country(
      name: 'Япония',
      capital: 'Токио',
      description: 'Страна восходящего солнца с богатой культурой',
      isVisited: false,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/en/thumb/9/9e/Flag_of_Japan.svg/1280px-Flag_of_Japan.svg.png',
    ),
    const Country(
      name: 'Италия',
      capital: 'Рим',
      description: 'Колыбель искусства и архитектуры',
      isVisited: false,
      imageUrl:
          'https://media.moddb.com/images/downloads/1/199/198503/1200px-Flag_of_the_Repubblica_Ci.png',
    ),
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _capitalController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

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
          imageUrl: _imageUrlController.text.isNotEmpty
              ? _imageUrlController.text
              : 'https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=400',
        ),
      );
    });
    _nameController.clear();
    _capitalController.clear();
    _descController.clear();
    _imageUrlController.clear();
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
      navigationBar: const CupertinoNavigationBar(middle: Text('Страны')),
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
                    CupertinoTextField(
                      controller: _imageUrlController,
                      placeholder: 'URL изображения (необязательно)',
                      padding: const EdgeInsets.all(12),
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
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: country.imageUrl,
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
                                        child: const Center(
                                          child: Icon(
                                            CupertinoIcons
                                                .exclamationmark_triangle,
                                            color: CupertinoColors.systemRed,
                                            size: 32,
                                          ),
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
