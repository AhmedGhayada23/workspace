import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/local_storage.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/navigation/app_navigator.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/features/auth/presentation/widgets/button_login_widget.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = sl<AppNavigator>();
    final storage = sl<LocalStorage>();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        color: AppColors.primary,
        child: Column(
          children: [
            SizedBox(height: 45.h),
            Center(child: Image.asset(AppImage.logoImage)),
            SizedBox(height: 24.h),
            Text(
              'مرحبًا!',
              textAlign: TextAlign.center,
              style: GoogleFonts.tajawal(
                color: const Color(0xFFFAFAFA),
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                height: 1.0,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'سجّل كمضيف أو قم بتسجيل الدخول لاستكشاف خدماتنا.',
              textAlign: TextAlign.center,
              style: GoogleFonts.tajawal(
                color: const Color(0xFFEEEEEE),
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 24.h),
            Container(
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
            Expanded(
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
                      ButtonLoginWidget(
                        text: 'تسجيل دخول',
                        onTap: () {
                          storage.writeValue(Constants.userType, 'normal');
                          nav.offAllToSignIn();
                        },
                      ),
                      SizedBox(height: 24.h),
                      InkWell(
                        onTap: () {
                          storage.writeValue(Constants.userType, 'visitor');
                          nav.offAllToHome();
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
                    ],
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
