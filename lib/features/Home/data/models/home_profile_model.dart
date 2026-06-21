import 'package:workspace/features/Home/domain/entities/home_profile.dart';

class HomeProfileModel extends HomeProfile {
  const HomeProfileModel({
    required super.name,
    required super.typeTitle,
    required super.imageUrl,
  });

  /// من استجابة /v1/profile/me: { data: { user: { name, customer: { image_url, type_title } } } }
  factory HomeProfileModel.fromResponse(Map<String, dynamic> json) {
    final user = (json['data'] is Map ? json['data']['user'] : null);
    final userMap = user is Map ? user : const {};
    final customer = userMap['customer'] is Map ? userMap['customer'] as Map : const {};
    return HomeProfileModel(
      name: (userMap['name'] ?? 'مستخدم').toString(),
      typeTitle: (customer['type_title'] ?? '-').toString(),
      imageUrl: (customer['image_url'] ?? '').toString(),
    );
  }
}
