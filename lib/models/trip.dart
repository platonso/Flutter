class Trip {
  final String destination;
  final String date;
  final String notes;
  final bool isCompleted;
  final String imageUrl;

  const Trip({
    required this.destination,
    required this.date,
    required this.notes,
    required this.isCompleted,
    required this.imageUrl,
  });

  Trip copyWith({
    String? destination,
    String? date,
    String? notes,
    bool? isCompleted,
    String? imageUrl,
  }) {
    return Trip(
      destination: destination ?? this.destination,
      date: date ?? this.date,
      notes: notes ?? this.notes,
      isCompleted: isCompleted ?? this.isCompleted,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'destination': destination,
      'date': date,
      'notes': notes,
      'isCompleted': isCompleted,
      'imageUrl': imageUrl,
    };
  }

  factory Trip.fromMap(Map<String, dynamic> map) {
    return Trip(
      destination: map['destination'] ?? '',
      date: map['date'] ?? 'Дата не указана',
      notes: map['notes'] ?? 'Без заметок',
      isCompleted: map['isCompleted'] ?? false,
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Trip(destination: $destination, date: $date, notes: $notes, isCompleted: $isCompleted, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Trip &&
        other.destination == destination &&
        other.date == date &&
        other.notes == notes &&
        other.isCompleted == isCompleted &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return destination.hashCode ^
        date.hashCode ^
        notes.hashCode ^
        isCompleted.hashCode ^
        imageUrl.hashCode;
  }
}
