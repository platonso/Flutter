import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/checklist_item.dart';
import '../../../providers/checklist_providers.dart';

class ChecklistScreen extends ConsumerStatefulWidget {
  const ChecklistScreen({super.key});

  @override
  ConsumerState<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends ConsumerState<ChecklistScreen> {
  final TextEditingController _nameController = TextEditingController();

  void _addItem() {
    if (_nameController.text.isEmpty) return;
    ref.read(checklistProvider.notifier).addChecklistItem(ChecklistItem(
      name: _nameController.text,
      category: 'Другое',
      isPacked: false,
    ));
    _nameController.clear();
  }

  void _togglePacked(int index) {
    ref.read(checklistProvider.notifier).togglePacked(index);
  }

  void _deleteItem(int index) {
    ref.read(checklistProvider.notifier).deleteChecklistItem(index);
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(checklistProvider);

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Чек-лист'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Форма добавления
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Добавить вещь',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 12),
                    CupertinoTextField(
                      controller: _nameController,
                      placeholder: 'Название вещи',
                      padding: const EdgeInsets.all(12),
                    ),
                    const SizedBox(height: 12),
                    CupertinoButton.filled(
                      onPressed: _addItem,
                      child: const Text('Добавить'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Список элементов
              Expanded(
                child: items.isEmpty
                    ? const Center(
                        child: Text(
                          'Пока нет вещей в чек-листе\nДобавьте первую!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: CupertinoColors.secondaryLabel,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () => _togglePacked(index),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: item.isPacked
                                      ? CupertinoColors.systemGreen.withOpacity(0.1)
                                      : CupertinoColors.systemGrey6,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: item.isPacked
                                        ? CupertinoColors.systemGreen
                                        : CupertinoColors.systemGrey4,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      item.isPacked
                                          ? CupertinoIcons.checkmark_circle_fill
                                          : CupertinoIcons.circle,
                                      color: item.isPacked
                                          ? CupertinoColors.systemGreen
                                          : CupertinoColors.systemGrey,
                                      size: 24,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        item.name,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: item.isPacked
                                              ? CupertinoColors.systemGrey
                                              : CupertinoColors.label,
                                          decoration: item.isPacked
                                              ? TextDecoration.lineThrough
                                              : null,
                                        ),
                                      ),
                                    ),
                                    CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () => _deleteItem(index),
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

