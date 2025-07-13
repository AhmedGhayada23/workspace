import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/features/bottom_navigation_bar/controllers/btn_nav_controller.dart';
import 'package:workspace/features/bottom_navigation_bar/presentation/widgets/btn_nav_widget.dart';


class BtnNavView extends GetView<BtnNavController> {
  const BtnNavView({super.key});

 @override
Widget build(BuildContext context) {
  final controller = Get.put(BtnNavController());

  return Scaffold(
    backgroundColor: AppColors.white,
    bottomNavigationBar: MediaQuery.of(context).viewInsets.bottom > 0
        ? null
        : Obx(
            () => BtnNavWidget(
              itemCount: controller.pages.length,
              activeIndex: controller.bottomNavIndex.value,
              onTap: controller.onItemSelected,
            ),
          ),
    body: Obx(
      () => PageView(
        controller: controller.pageController,
        onPageChanged: controller.changePage,
        children: controller.pages,
      ),
    ),
  );

  }
}
