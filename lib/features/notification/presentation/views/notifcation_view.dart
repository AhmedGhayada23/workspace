import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/features/bottom_navigation_bar/controllers/btn_nav_controller.dart';
import 'package:workspace/features/notification/controllers/notifcation_controller.dart';
import 'package:animate_do/animate_do.dart';
import 'package:workspace/features/notification/data/model/notification_model.dart' as model;
import 'package:workspace/features/notification/presentation/widgets/loading_notifcation.dart'; // استيراد مكتبة animate_do

class NotifcationView extends GetView<NotifcationController> {
  const NotifcationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotifcationController());
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: FadeInDown(
          child: Text(
            'الاشعارات',
            style: GoogleFonts.tajawal(
              color: Color(0xFF212121),
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        leading: FadeInDown(
          child: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back, size: 24.r, color: Color(0xFF212121)),
          ),
        ),

        actions: [
          Obx(
            ()=> IconButton(
            onPressed: () {
              controller.hasUnread.value ? controller.readNotifications() : null;
            },
            icon: SvgPicture.asset(
              AppSvg.readSvg,
              colorFilter: ColorFilter.mode(
                controller.hasUnread.value ? AppColors.primary : Color(0xFFBDBDBD),
                BlendMode.srcIn,
              ),
            ),
          ),
          ),
        ],
      ),
      body: PagedListView<int, model.Notifications>(
        pagingController: controller.pagingController,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        builderDelegate: PagedChildBuilderDelegate<model.Notifications>(
          itemBuilder: (context, notification, index) {
            return FadeInUp(
              duration: Duration(milliseconds: 600),
              child: InkWell(
                onTap: ()=> Get.find<BtnNavController>().pushNavigationBar(1),
                child: Container(
                  margin: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(
                    color: Color(0xFFFAFAFA),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInDown(
                        duration: Duration(milliseconds: 700),
                        child: Row(
                          children: [
                            Text(
                              '${notification.title ?? ''} - ${notification.data?.companyName ?? ''}',
                              style: GoogleFonts.tajawal(
                                color: Color(0xFF212121),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            Spacer(),
                            notification.readAt == null
                                ? CircleAvatar(radius: 4.r, backgroundColor: AppColors.primary)
                                : SizedBox.shrink(),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      FadeInUp(
                        duration: Duration(milliseconds: 700),
                        child: Text(
                          notification.body ?? '',
                          style: GoogleFonts.tajawal(
                            color: Color(0xFF757575),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      SizedBox(height: 8.h),

                      FadeInUp(
                        duration: Duration(milliseconds: 800),
                        child: Row(
                          children: [
                            Spacer(),
                            Text(
                              controller.timeAgo(notification.createdAt ?? ''),

                              style: GoogleFonts.tajawal(
                                color: Color(0xFF757575),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      //   if (notification. ?? false)
                      // BounceInUp(
                      //   duration: Duration(milliseconds: 900),
                      //   child: Row(
                      //     children: [
                      //       Spacer(),
                      //       ElevatedButton(
                      //         onPressed: () {
                      //           // TODO: تنفيذ إجراء التقييم
                      //         },
                      //         style: ElevatedButton.styleFrom(
                      //           backgroundColor: Color(0xFF32B599),
                      //           shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(50),
                      //           ),
                      //           padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                      //         ),
                      //         child: Text(
                      //           'قيم المساحة',
                      //           style: GoogleFonts.tajawal(
                      //             color: Colors.white,
                      //             fontSize: 16.sp,
                      //             fontWeight: FontWeight.w500,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            );
          },
          firstPageProgressIndicatorBuilder:
              (_) => Column(
                children: List.generate(
                  3,
                  (index) => LoadingNotifcation().buildNotificationShimmer(),
                ),
              ),
          newPageProgressIndicatorBuilder: (_) => Center(child: CircularProgressIndicator()),
          noItemsFoundIndicatorBuilder:
              (_) => Center(
                child: Text('لا توجد إشعارات حاليًا', style: GoogleFonts.tajawal(fontSize: 16.sp)),
              ),
          noMoreItemsIndicatorBuilder: (_) => SizedBox(height: 32.h),
        ),
      ),
    );
  }
}
