import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/local_storage.dart';
import 'package:workspace/core/services/fcm_token_service.dart';
import 'package:workspace/core/services/notification_service.dart';

part 'btn_nav_state.dart';

enum UserType { normal, visitor }

/// تبويب الشريط السفلي (ثابت).
class BtnTab {
  final String image;
  final String name;
  const BtnTab({required this.image, required this.name});
}

class BtnNavCubit extends Cubit<BtnNavState> {
  final LocalStorage localStorage;
  final NotificationService notificationService;
  final FcmTokenService fcmTokenService;

  BtnNavCubit({
    required this.localStorage,
    required this.notificationService,
    required this.fcmTokenService,
  }) : super(const BtnNavState());

  /// تبويبات الشريط السفلي.
  static const List<BtnTab> tabs = [
    BtnTab(image: 'assets/svg/home-2.svg', name: 'الرئيسية'),
    BtnTab(image: 'assets/svg/document-text.svg', name: 'حجوزاتي'),
    BtnTab(image: 'assets/svg/profile.svg', name: 'حسابي'),
  ];

  void init(int initialIndex) {
    notificationService.initializeForegroundNotificationForAndroid();
    notificationService.manageNotificationAction();

    final savedUserType = localStorage.readValue<String>(Constants.userType);
    final isVisitor = savedUserType == 'visitor';
    // المستخدم المصادَق عليه فقط: أرسل رمز FCM للخادم (/v1/store-token).
    if (!isVisitor) fcmTokenService.sync();
    emit(state.copyWith(
      currentIndex: initialIndex,
      userType: isVisitor ? UserType.visitor : UserType.normal,
    ));
  }

  void changeIndex(int index) => emit(state.copyWith(currentIndex: index));
}
