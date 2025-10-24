import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../models/trip.dart';

class PlannerScreen extends StatefulWidget {
  const PlannerScreen({super.key});

  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  final List<Trip> _trips = [];
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  void _addTrip() {
    if (_destinationController.text.isNotEmpty) {
      setState(() {
        _trips.add(Trip(
          destination: _destinationController.text,
          date: _dateController.text.isNotEmpty ? _dateController.text : 'Дата не указана',
          notes: _notesController.text.isNotEmpty ? _notesController.text : 'Без заметок',
          isCompleted: false,
          imageUrl: _imageUrlController.text.isNotEmpty ? _imageUrlController.text : 'https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=400',
        ));
      });
      _destinationController.clear();
      _dateController.clear();
      _notesController.clear();
      _imageUrlController.clear();
    }
  }

  void _toggleCompleted(int index) {
    setState(() {
      _trips[index] = _trips[index].copyWith(
        isCompleted: !_trips[index].isCompleted,
      );
    });
  }

  void _deleteTrip(int index) {
    setState(() {
      _trips.removeAt(index);
    });
  }



// ignore: unused_element
Widget _buildTripItem(Trip trip, int index) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    child: CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => _toggleCompleted(index),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: trip.isCompleted
              ? CupertinoColors.systemGreen.withOpacity(0.1)
              : CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: trip.isCompleted
                ? CupertinoColors.systemGreen
                : CupertinoColors.systemGrey4,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              trip.isCompleted
                  ? CupertinoIcons.checkmark_circle_fill
                  : CupertinoIcons.circle,
              color: trip.isCompleted
                  ? CupertinoColors.systemGreen
                  : CupertinoColors.systemGrey,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trip.destination,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: trip.isCompleted
                          ? CupertinoColors.systemGrey
                          : CupertinoColors.label,
                      decoration: trip.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    trip.date,
                    style: const TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.secondaryLabel,
                    ),
                  ),
                  if (trip.notes != 'Без заметок') ...[
                    const SizedBox(height: 4),
                    Text(
                      trip.notes,
                      style: const TextStyle(
                        fontSize: 12,
                        color: CupertinoColors.tertiaryLabel,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _deleteTrip(index),
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
}



  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Планировщик'),
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
                      'Добавить поездку',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CupertinoTextField(
                      controller: _destinationController,
                      placeholder: 'Куда поедете?',
                      padding: const EdgeInsets.all(12),
                    ),
                    const SizedBox(height: 12),
                    CupertinoTextField(
                      controller: _dateController,
                      placeholder: 'Когда? (например: 15.10.2025)',
                      padding: const EdgeInsets.all(12),
                    ),
                    const SizedBox(height: 12),
                    CupertinoTextField(
                      controller: _notesController,
                      placeholder: 'Заметки (необязательно)',
                      padding: const EdgeInsets.all(12),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 12),
                    CupertinoTextField(
                      controller: _imageUrlController,
                      placeholder: 'URL изображения (необязательно)',
                      padding: const EdgeInsets.all(12),
                    ),
                    const SizedBox(height: 16),
                    CupertinoButton.filled(
                      onPressed: _addTrip,
                      child: const Text('Добавить поездку'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: _trips.isEmpty
                    ? const Center(
                        child: Text(
                          'Пока нет запланированных поездок\nДобавьте первую!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: CupertinoColors.secondaryLabel,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _trips.length,
                        itemBuilder: (context, index) {
                          final trip = _trips[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () => _toggleCompleted(index),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: trip.isCompleted
                                      ? CupertinoColors.systemGreen.withOpacity(0.1)
                                      : CupertinoColors.systemGrey6,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: trip.isCompleted
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
                                        imageUrl: trip.imageUrl,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Container(
                                          width: 60,
                                          height: 60,
                                          color: CupertinoColors.systemGrey5,
                                          child: const Icon(
                                            CupertinoIcons.photo,
                                            color: CupertinoColors.systemGrey,
                                            size: 24,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) => Container(
                                          width: 60,
                                          height: 60,
                                          color: CupertinoColors.systemGrey5,
                                          child: const Icon(
                                            CupertinoIcons.exclamationmark_triangle,
                                            color: CupertinoColors.systemRed,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            trip.destination,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: trip.isCompleted
                                                  ? CupertinoColors.systemGrey
                                                  : CupertinoColors.label,
                                              decoration: trip.isCompleted
                                                  ? TextDecoration.lineThrough
                                                  : null,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            trip.date,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: CupertinoColors.secondaryLabel,
                                            ),
                                          ),
                                          if (trip.notes != 'Без заметок') ...[
                                            const SizedBox(height: 4),
                                            Text(
                                              trip.notes,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: CupertinoColors.tertiaryLabel,
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                    CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () => _deleteTrip(index),
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



