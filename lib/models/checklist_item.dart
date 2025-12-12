class ChecklistItem {
  final String name;
  final String category;
  final bool isPacked;

  const ChecklistItem({
    required this.name,
    required this.category,
    required this.isPacked,
  });

  ChecklistItem copyWith({
    String? name,
    String? category,
    bool? isPacked,
  }) {
    return ChecklistItem(
      name: name ?? this.name,
      category: category ?? this.category,
      isPacked: isPacked ?? this.isPacked,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'isPacked': isPacked,
    };
  }

  factory ChecklistItem.fromMap(Map<String, dynamic> map) {
    return ChecklistItem(
      name: map['name'] ?? '',
      category: map['category'] ?? 'Другое',
      isPacked: map['isPacked'] ?? false,
    );
  }

  @override
  String toString() {
    return 'ChecklistItem(name: $name, category: $category, isPacked: $isPacked)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChecklistItem &&
        other.name == name &&
        other.category == category &&
        other.isPacked == isPacked;
  }

  @override
  int get hashCode {
    return name.hashCode ^ category.hashCode ^ isPacked.hashCode;
  }
}


