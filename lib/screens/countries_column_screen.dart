import 'package:flutter/cupertino.dart';

class CountriesColumnScreen extends StatefulWidget {
  const CountriesColumnScreen({super.key});

  @override
  State<CountriesColumnScreen> createState() => _CountriesColumnScreenState();
}

class _CountriesColumnScreenState extends State<CountriesColumnScreen> {
  final List<Map<String, String>> _countries = [
    {'id': '1', 'name': 'Франция'},
    {'id': '2', 'name': 'Япония'},
    {'id': '3', 'name': 'Бразилия'},
  ];

  void _addCountry() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Добавить страну'),
        content: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: CupertinoTextField(
            placeholder: 'Название страны',
            onChanged: (value) => _newCountryName = value,
            autofocus: true,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Отмена'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            child: const Text('Добавить'),
            onPressed: () {
              if (_newCountryName.isNotEmpty) {
                setState(() {
                  _countries.add({
                    'id': DateTime.now().millisecondsSinceEpoch.toString(),
                    'name': _newCountryName,
                  });
                });
                Navigator.pop(context);
                _clearNewCountryFields();
              }
            },
          ),
        ],
      ),
    );
  }

  void _deleteCountry(String id) {
    setState(() {
      _countries.removeWhere((country) => country['id'] == id);
    });
  }

  void _clearNewCountryFields() {
    _newCountryName = '';
  }

  String _newCountryName = '';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Страны')),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CupertinoButton.filled(
                onPressed: _addCountry,
                child: const Text('Добавить страну'),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: _countries
                      .map((country) => _buildCountryCard(country))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCountryCard(Map<String, String> country) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: CupertinoColors.systemGrey4, width: 1.0),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: CupertinoColors.activeBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Icon(
              CupertinoIcons.globe,
              color: CupertinoColors.activeBlue,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              country['name']!,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => _deleteCountry(country['id']!),
            child: const Icon(
              CupertinoIcons.delete,
              color: CupertinoColors.destructiveRed,
            ),
          ),
        ],
      ),
    );
  }
}
