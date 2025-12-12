import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/checklist_item.dart';
import '../services/data_service.dart';
import 'data_service_provider.dart';

// Провайдер для списка элементов чек-листа
final checklistProvider = StateNotifierProvider<ChecklistNotifier, List<ChecklistItem>>((ref) {
  final dataService = ref.watch(dataServiceProvider);
  return ChecklistNotifier(dataService);
});

class ChecklistNotifier extends StateNotifier<List<ChecklistItem>> {
  final DataService _dataService;

  ChecklistNotifier(this._dataService) : super(_dataService.checklistItems);

  void addChecklistItem(ChecklistItem item) {
    _dataService.addChecklistItem(item);
    state = List.from(_dataService.checklistItems);
  }

  void updateChecklistItem(int index, ChecklistItem item) {
    _dataService.updateChecklistItem(index, item);
    state = List.from(_dataService.checklistItems);
  }

  void deleteChecklistItem(int index) {
    _dataService.deleteChecklistItem(index);
    state = List.from(_dataService.checklistItems);
  }

  void togglePacked(int index) {
    final items = List<ChecklistItem>.from(state);
    if (index >= 0 && index < items.length) {
      items[index] = items[index].copyWith(isPacked: !items[index].isPacked);
      _dataService.updateChecklistItem(index, items[index]);
      state = List.from(_dataService.checklistItems);
    }
  }

  void refresh() {
    state = List.from(_dataService.checklistItems);
  }
}

