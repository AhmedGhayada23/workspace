import 'package:equatable/equatable.dart';

/// كيان مبسّط لمساحة العمل (الحقول التي تعرضها بطاقات الشاشة فقط).
class SpaceItem extends Equatable {
  final int id;
  final String typeTitle;
  final String image;
  final String nameCompany;
  final String ratingCount;
  final String ratingAverage;
  final String address;
  final String availableFrom;
  final String availableTo;
  final String email;
  final String mobile;

  const SpaceItem({
    required this.id,
    required this.typeTitle,
    required this.image,
    required this.nameCompany,
    required this.ratingCount,
    required this.ratingAverage,
    required this.address,
    required this.availableFrom,
    required this.availableTo,
    required this.email,
    required this.mobile,
  });

  @override
  List<Object?> get props => [
        id,
        typeTitle,
        image,
        nameCompany,
        ratingCount,
        ratingAverage,
        address,
        availableFrom,
        availableTo,
        email,
        mobile,
      ];
}
