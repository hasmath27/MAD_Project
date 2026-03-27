class BookingModel {
  final String id;
  final String placeId;
  final String placeName;
  final String placeImage;
  final int nights;
  final double totalPrice;
  final String status;
  final String travelDate;
  final DateTime? createdAt;

  BookingModel({
    required this.id,
    required this.placeId,
    required this.placeName,
    required this.placeImage,
    required this.nights,
    required this.totalPrice,
    required this.status,
    required this.travelDate,
    this.createdAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id']?.toString() ?? '',
      placeId: json['place_id']?.toString() ?? '',
      placeName: json['place_name']?.toString() ?? '',
      placeImage: json['place_image']?.toString() ?? '',
      nights: (json['nights'] as num?)?.toInt() ?? 1,
      totalPrice: (json['total_price'] as num?)?.toDouble() ?? 0.0,
      status: json['status']?.toString() ?? 'upcoming',
      travelDate: json['travel_date']?.toString() ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'place_id': placeId,
      'place_name': placeName,
      'place_image': placeImage,
      'nights': nights,
      'total_price': totalPrice,
      'status': status,
      'travel_date': travelDate,
    };
  }
}
