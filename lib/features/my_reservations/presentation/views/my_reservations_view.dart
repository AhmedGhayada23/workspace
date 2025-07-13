import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/features/my_reservations/controllers/my_reservations_controller.dart';
import 'package:workspace/features/my_reservations/data/models/order_model.dart';
import 'package:workspace/features/my_reservations/presentation/widgets/card_my_resevation_widget.dart';
import 'package:workspace/features/my_reservations/presentation/widgets/items_widget.dart';
import 'package:workspace/features/my_reservations/presentation/widgets/loading_my_reservation.dart';
import 'package:workspace/utils/routing.dart';

class MyReservationsView extends GetView<MyReservationsController> {
  const MyReservationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyReservationsController());
    return Scaffold(
      backgroundColor: AppColors.white,

      body: DefaultTabController(
        length: controller.tabs.length,
        child: NestedScrollView(
          headerSliverBuilder:
              (context, innerBoxScrolled) => [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  elevation: 1,
                  automaticallyImplyLeading: false,
                  pinned: true,
                  title: Center(
                    child: FadeInDown(
                      delay: Duration(milliseconds: 1000),
                      child: Text(
                        'حجوزاتي',
                        style: GoogleFonts.tajawal(
                          color: const Color(0xFF212121),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  bottom: TabBar(
                    onTap: (index) {
                      if (index == 0) {
                        controller.status.value = index;
                        log('message value 0 :: $index ,, ${controller.status.value}');
                        controller.pagingController.refresh();
                      } else if (index == 1) {
                        controller.status.value = index;

                        log('message value 1 :: $index ,, ${controller.status.value}');
                          controller.pagingController.refresh();
                      } else if (index == 2) {
                        controller.status.value = index;
                        log('message value 2 :: $index ,, ${controller.status.value}');
                        controller.pagingController.refresh();
                      } else {
                        controller.status.value = index;
                        log('message value 3 :: $index ,, ${controller.status.value}');
                         controller.pagingController.refresh();
                      }
                    },
                    controller: controller.tabController,
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 1.w),
                    padding: EdgeInsets.symmetric(horizontal: 1.w),
                    labelPadding: EdgeInsets.symmetric(horizontal: 1.w),
                    labelColor: AppColors.primary,
                    unselectedLabelColor: const Color(0xFF616161),
                    indicatorColor: AppColors.primary,
                    indicatorWeight: 1,
                    dividerColor: Color(0xFFF5F5F5),
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle: GoogleFonts.tajawal(fontSize: 16.sp, fontWeight: FontWeight.w500),
                    unselectedLabelStyle: GoogleFonts.tajawal(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    tabs: controller.tabs.map((t) => Text(t)).toList(),
                  ),
                ),
              ],
          body: TabBarView(
  controller: controller.tabController,
  children: List.generate(controller.tabs.length, (index) {
    return CustomScrollView(
      slivers: [
        PagedSliverList<int, Reservations>(
  pagingController: controller.pagingController,
  builderDelegate: PagedChildBuilderDelegate<Reservations>(
    itemBuilder: (context, item, index) => Padding(
      padding: EdgeInsets.all(16.r),
      child: CardMyResevationWidget(
        reservations: item,
        show: true,
        onTap: () => Get.toNamed(
          AppRouting.detailsMyReservationsView,
          arguments: item,
        ),
      ),
    ),
    firstPageProgressIndicatorBuilder: (context) =>
        Column(
          children: [
            LoadingMyReservation().cardShimmerMyResevation,
            LoadingMyReservation().cardShimmerMyResevation,
            LoadingMyReservation().cardShimmerMyResevation,
          ],
        ),

    newPageProgressIndicatorBuilder: (context) =>
        SpinKitFadingCircle(
                        color: AppColors.primary,
                        size: 50.0,
                        duration: Duration(milliseconds: 1200),
                        controller: controller.animationController),

    noItemsFoundIndicatorBuilder: (context) =>
        _NoDatabuildTabContent(''),
  ),
),

      ],
    );
  }),
),

        ),
      ),
    );
  }



 Widget _NoDatabuildTabContent(String title) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NoItemsWidget(),
        SizedBox(height: 12.h),
        Text(title, style: TextStyle(fontSize: 14.sp)),
      ],
    ),
  );
}

}
