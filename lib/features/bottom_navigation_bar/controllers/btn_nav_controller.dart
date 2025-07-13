import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/local_storage.dart';
import 'package:workspace/core/network/network_manager.dart';
import 'package:workspace/features/Home/presentation/views/home_view.dart';
import 'package:workspace/features/bottom_navigation_bar/data/models/btn_model.dart';
import 'package:workspace/features/my_reservations/presentation/views/my_reservations_view.dart';
import 'package:workspace/features/profile/presentation/views/profile_view.dart';
import 'package:workspace/features/visitor_home/presentation/views/visitor_home_view.dart';
import 'package:workspace/features/visitor_profile/presentation/views/visitor_profile_view.dart';
import 'package:workspace/features/visitor_resevations/presentation/views/visitor_resevations_view.dart';
import 'package:workspace/utils/fb_notifications.dart';
import 'package:workspace/utils/routing.dart';

enum UserType { normal, visitor }

class BtnNavController extends GetxController with FbNotifications {
  late PageController pageController;
  RxInt bottomNavIndex = 0.obs;
  bool hasShownInitialConnection = false;

  // نوع المستخدم
  Rx<UserType> userType = UserType.normal.obs;

  // زرار التنقل (ثابتة هنا، لكن ممكن تتغير لو أردت تخصيصها حسب النوع)
  List<BtnModel> btnData = <BtnModel>[
    BtnModel(id: 1, image: 'assets/svg/home-2.svg', name: 'الرئيسية'),
    BtnModel(id: 2, image: 'assets/svg/document-text.svg', name: 'حجوزاتي'),
    BtnModel(id: 3, image: 'assets/svg/profile.svg', name: 'حسابي'),
  ];

  @override
  void onInit() {
    initializeForegroundNotificationForAndroid();

    Map<String, String>? parameter = Get.arguments as Map<String, String>?;
    String? index = parameter?['bottomNavIndex'];

    if (index != null) {
      bottomNavIndex(int.parse(index));
      pageController = PageController(initialPage: bottomNavIndex.value);
    } else {
      pageController = PageController(initialPage: bottomNavIndex.value);
    }

    String? savedUserType = LocalStorage().readValue(Constants.userType);
    if (savedUserType == 'visitor') {
    userType.value = UserType.visitor;
  } else {
    userType.value = UserType.normal;
  }

    NetworkManager().initListener();
    super.onInit();
  }

  void onItemSelected(int value) {
    bottomNavIndex.value = value;
    pageController.jumpToPage(value);
  }

  void changePage(int index) {
    bottomNavIndex.value = index;
  }

  void pushNavigationBar(int index) async {
    log('index Btn ::${bottomNavIndex.value}');
    Get.offAllNamed(AppRouting.btnNavView, arguments: {'bottomNavIndex': '$index'});
  }

  // قائمة الصفحات بناءً على نوع المستخدم
  List<Widget> get pages {
    if (userType.value == UserType.normal) {
      return [const HomeView(), const MyReservationsView(), const ProfileView()];
    } else {
      return [
        const VisitorHomeView(),
        const VisitorResevationsView(),
        const VisitorProfileView(),
      ];
    }
  }
}
