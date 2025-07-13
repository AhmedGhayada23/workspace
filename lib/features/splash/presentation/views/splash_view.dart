import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/local_storage.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/features/auth/presentation/widgets/button_login_widget.dart';
import 'package:workspace/features/splash/controllers/splash_controller.dart';
import 'package:workspace/utils/routing.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        color: AppColors.primary,
        child: Column(
          children: [
            SizedBox(height: 45.h),
            FadeInRight(
              duration: const Duration(milliseconds: 700),
              child: Center(child: Image.asset(AppImage.logoImage)),
            ),
            SizedBox(height: 24.h),
            FadeInDown(
              duration: const Duration(milliseconds: 800),
              child: Text(
                'مرحبًا!',
                textAlign: TextAlign.center,
                style: GoogleFonts.tajawal(
                  color: const Color(0xFFFAFAFA),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  height: 1.0,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            FadeInDown(
              delay: const Duration(milliseconds: 300),
              child: Text(
                'سجّل كمضيف أو قم بتسجيل الدخول لاستكشاف خدماتنا.',
                textAlign: TextAlign.center,
                style: GoogleFonts.tajawal(
                  color: const Color(0xFFEEEEEE),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,

                ),
              ),
            ),
            SizedBox(height: 24.h),
            FadeIn(
              delay: const Duration(milliseconds: 500),
              child: Container(
                height: 16.h,
                margin: EdgeInsets.symmetric(horizontal: 35.w),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(20, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FadeInUp(
                duration: const Duration(milliseconds: 600),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 32.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 60.h),
                        FadeInUp(
                          delay: const Duration(milliseconds: 400),
                          child: ButtonLoginWidget(
                            text: 'login'.tr,
                            onTap: () {
                             LocalStorage().writeValue(Constants.userType, 'normal');
                              Get.offAllNamed(AppRouting.signInView);
                            },
                          ),
                        ),
                        SizedBox(height: 24.h),
                        FadeInUp(
                          delay: const Duration(milliseconds: 600),
                          child: InkWell(
                            onTap: () {
                              LocalStorage().writeValue(Constants.userType, 'visitor');
                              Get.offAllNamed(AppRouting.btnNavView);
                            },
                            child: Container(
                              height: 48.h,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(50.r),
                                border: Border.all(width: 1.w, color: AppColors.primary),
                              ),
                              child: Center(
                                child: Text(
                                  'الاستمرار كضيف',
                                  style: GoogleFonts.tajawal(
                                    color: AppColors.primary,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
