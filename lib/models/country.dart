class Country {
  final String name;
  final String capital;
  final String flag;
  final String description;
  final bool isVisited;

  const Country({
    required this.name,
    required this.capital,
    required this.flag,
    required this.description,
    required this.isVisited,
  });

  Country copyWith({
    String? name,
    String? capital,
    String? flag,
    String? description,
    bool? isVisited,
  }) {
    return Country(
      name: name ?? this.name,
      capital: capital ?? this.capital,
      flag: flag ?? this.flag,
      description: description ?? this.description,
      isVisited: isVisited ?? this.isVisited,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'capital': capital,
      'flag': flag,
      'description': description,
      'isVisited': isVisited,
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      name: map['name'] ?? '',
      capital: map['capital'] ?? '',
      flag: map['flag'] ?? '🏳️',
      description: map['description'] ?? 'Описание отсутствует',
      isVisited: map['isVisited'] ?? false,
    );
  }

  @override
  String toString() {
    return 'Country(name: $name, capital: $capital, flag: $flag, description: $description, isVisited: $isVisited)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Country &&
        other.name == name &&
        other.capital == capital &&
        other.flag == flag &&
        other.description == description &&
        other.isVisited == isVisited;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        capital.hashCode ^
        flag.hashCode ^
        description.hashCode ^
        isVisited.hashCode;
  }
}
