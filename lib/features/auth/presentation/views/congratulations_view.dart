import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/features/auth/controllers/congratulations_controller.dart';
import 'package:workspace/features/auth/presentation/widgets/button_login_widget.dart';
import 'package:workspace/utils/routing.dart';

class CongratulationsView extends GetView<CongratulationsController> {
  const CongratulationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        color: AppColors.primary,
        child: Column(
          children: [
            SizedBox(height: 45.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FadeInLeft(
                    child: IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: AppColors.white,
                        size: 24.r,
                      ),
                    ),
                  ),
                  FadeInRight(
                    child: Center(
                  child: Image.asset(AppImage.logoImage),
                ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            FadeIn(
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
                        SizedBox(height: 24.sp),
                        FadeIn(
                          duration: const Duration(milliseconds: 600),
                          child: Center(
                            child: SvgPicture.asset(AppSvg.congratulationsSvg),
                          ),
                        ),
                        SizedBox(height: 16.sp),
                        FadeInDown(
                          delay: const Duration(milliseconds: 200),
                          child: Center(
                            child: Text(
                              'تهانينا!'.tr,
                              style: GoogleFonts.tajawal(
                                color: AppColors.black,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 4.sp),
                        FadeInDown(
                          delay: const Duration(milliseconds: 300),
                          child: Center(
                            child: Text(
                              'لقد تم تغيير كلمة مرور حسابك بنجاح , يمكنك الان العودة وتسجيل الدخول من جديد !'.tr,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.tajawal(
                                color: const Color(0xFF616161),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 32.sp),
                        FadeInUp(
                          delay: const Duration(milliseconds: 400),
                          child: ButtonLoginWidget(
                            text: 'login'.tr,
                            onTap: () => Get.offAllNamed(AppRouting.signInView),
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
