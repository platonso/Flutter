import 'package:flutter/cupertino.dart';

class TravelPlansListViewSeparatedScreen extends StatefulWidget {
  const TravelPlansListViewSeparatedScreen({super.key});

  @override
  State<TravelPlansListViewSeparatedScreen> createState() =>
      _TravelPlansListViewSeparatedScreenState();
}

class _TravelPlansListViewSeparatedScreenState
    extends State<TravelPlansListViewSeparatedScreen> {
  final List<Map<String, String>> _travelPlans = [
    {'id': '1', 'country': 'Франция', 'city': 'Париж'},
    {'id': '2', 'country': 'Япония', 'city': 'Токио'},
    {'id': '3', 'country': 'Италия', 'city': 'Рим'},
  ];

  void _addTravelPlan() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Добавить план путешествия'),
        content: Container(
          height: 180,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              CupertinoTextField(
                placeholder: 'Страна',
                onChanged: (value) => _newPlanCountry = value,
                autofocus: true,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              CupertinoTextField(
                placeholder: 'Город',
                onChanged: (value) => _newPlanCity = value,
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
              if (_newPlanCountry.isNotEmpty && _newPlanCity.isNotEmpty) {
                setState(() {
                  _travelPlans.add({
                    'id': DateTime.now().millisecondsSinceEpoch.toString(),
                    'country': _newPlanCountry,
                    'city': _newPlanCity,
                  });
                });
                Navigator.pop(context);
                _clearNewPlanFields();
              }
            },
          ),
        ],
      ),
    );
  }

  void _deleteTravelPlan(String id) {
    setState(() {
      _travelPlans.removeWhere((plan) => plan['id'] == id);
    });
  }

  void _clearNewPlanFields() {
    _newPlanCountry = '';
    _newPlanCity = '';
  }

  String _newPlanCountry = '';
  String _newPlanCity = '';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Планы путешествий'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CupertinoButton.filled(
                onPressed: _addTravelPlan,
                child: const Text('Добавить план путешествия'),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: _travelPlans.length,
                separatorBuilder: (context, index) => Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  color: CupertinoColors.systemGrey4,
                ),
                itemBuilder: (context, index) {
                  final plan = _travelPlans[index];
                  return _buildTravelPlanCard(plan);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTravelPlanCard(Map<String, String> plan) {
    return Container(
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
              CupertinoIcons.airplane,
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
                  plan['city']!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  plan['country']!,
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
            onPressed: () => _deleteTravelPlan(plan['id']!),
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
