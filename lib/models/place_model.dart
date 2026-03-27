class PlaceModel {
  final String id;
  final String name;
  final String location;
  final String country;
  final String description;
  final String imageUrl;
  final double rating;
  final double price;
  final String distance;
  final String category;
  final List<String> tags;
  bool isFavorite;
  final DateTime? createdAt;

  PlaceModel({
    required this.id,
    required this.name,
    required this.location,
    required this.country,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.price,
    required this.distance,
    required this.category,
    required this.tags,
    this.isFavorite = false,
    this.createdAt,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['id'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
      country: json['country'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String,
      rating: (json['rating'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      distance: json['distance'] as String,
      category: json['category'] as String,
      tags: List<String>.from(json['tags'] ?? []),
      isFavorite: json['is_favorite'] as bool? ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
      'country': country,
      'description': description,
      'image_url': imageUrl,
      'rating': rating,
      'price': price,
      'distance': distance,
      'category': category,
      'tags': tags,
      'is_favorite': isFavorite,
    };
  }

  PlaceModel copyWith({
    String? id,
    String? name,
    String? location,
    String? country,
    String? description,
    String? imageUrl,
    double? rating,
    double? price,
    String? distance,
    String? category,
    List<String>? tags,
    bool? isFavorite,
  }) {
    return PlaceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      country: country ?? this.country,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      price: price ?? this.price,
      distance: distance ?? this.distance,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
