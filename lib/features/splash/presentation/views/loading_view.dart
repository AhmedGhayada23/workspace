import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/features/splash/controllers/loading_controller.dart';

class LoadingView extends GetView<LoadingController> {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 3),
            // الشعار في المنتصف — مطابق للـ native splash لانتقال سلس
            FadeInDown(
              duration: const Duration(milliseconds: 700),
              child: Image.asset(
                AppImage.splashLogoImage,
                width: 225.w,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 16.h),
            FadeIn(
              delay: const Duration(milliseconds: 400),
              duration: const Duration(milliseconds: 600),
              child: Text(
                'Areisto Space',
                textAlign: TextAlign.center,
                style: GoogleFonts.tajawal(
                  color: AppColors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Spacer(flex: 2),
            // مؤشر التحميل
            FadeInUp(
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 600),
              child: SpinKitThreeBounce(
                color: AppColors.white,
                size: 28.w,
              ),
            ),
            SizedBox(height: 14.h),
            FadeInUp(
              delay: const Duration(milliseconds: 600),
              duration: const Duration(milliseconds: 600),
              child: Text(
                'جارٍ التحميل...',
                textAlign: TextAlign.center,
                style: GoogleFonts.tajawal(
                  color: const Color(0xFFEEEEEE),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 48.h),
          ],
        ),
      ),
    );
  }
}
