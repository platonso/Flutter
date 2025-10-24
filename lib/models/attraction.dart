class Attraction {
  final String name;
  final String location;
  final String icon;
  final String description;
  final bool isFavorite;
  final String imageUrl;

  const Attraction({
    required this.name,
    required this.location,
    required this.icon,
    required this.description,
    required this.isFavorite,
    required this.imageUrl,
  });

  Attraction copyWith({
    String? name,
    String? location,
    String? icon,
    String? description,
    bool? isFavorite,
    String? imageUrl,
  }) {
    return Attraction(
      name: name ?? this.name,
      location: location ?? this.location,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location,
      'icon': icon,
      'description': description,
      'isFavorite': isFavorite,
      'imageUrl': imageUrl,
    };
  }

  factory Attraction.fromMap(Map<String, dynamic> map) {
    return Attraction(
      name: map['name'] ?? '',
      location: map['location'] ?? '',
      icon: map['icon'] ?? 'Место',
      description: map['description'] ?? 'Описание отсутствует',
      isFavorite: map['isFavorite'] ?? false,
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Attraction(name: $name, location: $location, icon: $icon, description: $description, isFavorite: $isFavorite, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Attraction &&
        other.name == name &&
        other.location == location &&
        other.icon == icon &&
        other.description == description &&
        other.isFavorite == isFavorite &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        location.hashCode ^
        icon.hashCode ^
        description.hashCode ^
        isFavorite.hashCode ^
        imageUrl.hashCode;
  }
}
