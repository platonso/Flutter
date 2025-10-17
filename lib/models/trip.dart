class Trip {
  final String destination;
  final String date;
  final String notes;
  final bool isCompleted;

  const Trip({
    required this.destination,
    required this.date,
    required this.notes,
    required this.isCompleted,
  });

  Trip copyWith({
    String? destination,
    String? date,
    String? notes,
    bool? isCompleted,
  }) {
    return Trip(
      destination: destination ?? this.destination,
      date: date ?? this.date,
      notes: notes ?? this.notes,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'destination': destination,
      'date': date,
      'notes': notes,
      'isCompleted': isCompleted,
    };
  }

  factory Trip.fromMap(Map<String, dynamic> map) {
    return Trip(
      destination: map['destination'] ?? '',
      date: map['date'] ?? 'Дата не указана',
      notes: map['notes'] ?? 'Без заметок',
      isCompleted: map['isCompleted'] ?? false,
    );
  }

  @override
  String toString() {
    return 'Trip(destination: $destination, date: $date, notes: $notes, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Trip &&
        other.destination == destination &&
        other.date == date &&
        other.notes == notes &&
        other.isCompleted == isCompleted;
  }

  @override
  int get hashCode {
    return destination.hashCode ^
        date.hashCode ^
        notes.hashCode ^
        isCompleted.hashCode;
  }
}
