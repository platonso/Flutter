import 'package:flutter/cupertino.dart';

class AttractionsListViewScreen extends StatefulWidget {
  const AttractionsListViewScreen({super.key});

  @override
  State<AttractionsListViewScreen> createState() =>
      _AttractionsListViewScreenState();
}

class _AttractionsListViewScreenState extends State<AttractionsListViewScreen> {
  final List<Map<String, String>> _attractions = [
    {'id': '1', 'name': 'Эйфелева башня', 'country': 'Франция'},
    {'id': '2', 'name': 'Тадж-Махал', 'country': 'Индия'},
    {'id': '3', 'name': 'Статуя Свободы', 'country': 'США'},
    {'id': '4', 'name': 'Колизей', 'country': 'Италия'},
  ];

  void _addAttraction() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Добавить достопримечательность'),
        content: Container(
          height: 180,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              CupertinoTextField(
                placeholder: 'Название',
                onChanged: (value) => _newAttractionName = value,
                autofocus: true,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              CupertinoTextField(
                placeholder: 'Страна',
                onChanged: (value) => _newAttractionCountry = value,
                style: const TextStyle(fontSize: 16),
              ),
            ],
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
              if (_newAttractionName.isNotEmpty &&
                  _newAttractionCountry.isNotEmpty) {
                setState(() {
                  _attractions.add({
                    'id': DateTime.now().millisecondsSinceEpoch.toString(),
                    'name': _newAttractionName,
                    'country': _newAttractionCountry,
                  });
                });
                Navigator.pop(context);
                _clearNewAttractionFields();
              }
            },
          ),
        ],
      ),
    );
  }

  void _deleteAttraction(String id) {
    setState(() {
      _attractions.removeWhere((attraction) => attraction['id'] == id);
    });
  }

  void _clearNewAttractionFields() {
    _newAttractionName = '';
    _newAttractionCountry = '';
  }

  String _newAttractionName = '';
  String _newAttractionCountry = '';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Достопримечательности'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CupertinoButton.filled(
                onPressed: _addAttraction,
                child: const Text('Добавить достопримечательность'),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: _attractions.length,
                itemBuilder: (context, index) {
                  final attraction = _attractions[index];
                  return _buildAttractionCard(attraction);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttractionCard(Map<String, String> attraction) {
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
              CupertinoIcons.location,
              color: CupertinoColors.activeBlue,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attraction['name']!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  attraction['country']!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: CupertinoColors.activeBlue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => _deleteAttraction(attraction['id']!),
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
