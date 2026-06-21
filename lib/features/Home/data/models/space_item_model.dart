import 'package:workspace/features/Home/domain/entities/space_item.dart';

class SpaceItemModel extends SpaceItem {
  const SpaceItemModel({
    required super.id,
    required super.typeTitle,
    required super.image,
    required super.nameCompany,
    required super.ratingCount,
    required super.ratingAverage,
    required super.address,
    required super.availableFrom,
    required super.availableTo,
    required super.email,
    required super.mobile,
  });

  factory SpaceItemModel.fromJson(Map<String, dynamic> json) {
    final company = json['company'] is Map ? json['company'] as Map : const {};
    return SpaceItemModel(
      id: json['id'] is int ? json['id'] as int : 0,
      typeTitle: (company['type_title'] ?? '-').toString(),
      image: (json['main_image_url'] ?? '').toString(),
      nameCompany: (company['name'] ?? '-').toString(),
      ratingCount: (json['customer_rating_count'] ?? '0').toString(),
      ratingAverage: (json['rating_average'] ?? '0').toString(),
      address: (json['address'] ?? '-').toString(),
      availableFrom: (json['available_from'] ?? '').toString(),
      availableTo: (json['available_to'] ?? '').toString(),
      email: (json['email'] ?? '-').toString(),
      mobile: (json['mobile'] ?? '-').toString(),
    );
  }
}
