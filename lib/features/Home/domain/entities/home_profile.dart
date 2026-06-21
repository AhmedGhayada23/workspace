import 'package:equatable/equatable.dart';

/// بيانات المستخدم المختصرة المعروضة في هيدر الرئيسية.
class HomeProfile extends Equatable {
  final String name;
  final String typeTitle;
  final String imageUrl;

  const HomeProfile({
    required this.name,
    required this.typeTitle,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [name, typeTitle, imageUrl];
}
