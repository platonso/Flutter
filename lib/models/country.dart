class Country {
  final String name;
  final String capital;
  final String description;
  final bool isVisited;
  final String imageUrl;

  const Country({
    required this.name,
    required this.capital,
    required this.description,
    required this.isVisited,
    required this.imageUrl,
  });

  Country copyWith({
    String? name,
    String? capital,
    String? description,
    bool? isVisited,
    String? imageUrl,
  }) {
    return Country(
      name: name ?? this.name,
      capital: capital ?? this.capital,
      description: description ?? this.description,
      isVisited: isVisited ?? this.isVisited,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'capital': capital,
      'description': description,
      'isVisited': isVisited,
      'imageUrl': imageUrl,
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      name: map['name'] ?? '',
      capital: map['capital'] ?? '',
      description: map['description'] ?? 'Описание отсутствует',
      isVisited: map['isVisited'] ?? false,
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Country(name: $name, capital: $capital, description: $description, isVisited: $isVisited, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Country &&
        other.name == name &&
        other.capital == capital &&
        other.description == description &&
        other.isVisited == isVisited &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        capital.hashCode ^
        description.hashCode ^
        isVisited.hashCode ^
        imageUrl.hashCode;
  }
}
