import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/local_storage.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/navigation/app_navigator.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';

class LoadingView extends StatefulWidget {
  const LoadingView({super.key});

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  @override
  void initState() {
    super.initState();
    _decideNextRoute();
  }

  Future<void> _decideNextRoute() async {
    // وقت بسيط لإظهار شاشة التحميل بسلاسة (انتقال سلس من الـ native splash).
    await Future.delayed(const Duration(milliseconds: 2200));
    if (!mounted) return;
    final hasToken = sl<LocalStorage>().readValue(Constants.token) != null;
    hasToken
        ? sl<AppNavigator>().offAllToHome()
        : sl<AppNavigator>().offAllToSplash();
  }

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
            Image.asset(AppImage.splashLogoImage,
                width: 225.w, fit: BoxFit.contain),
            const Spacer(flex: 2),
            SpinKitThreeBounce(color: AppColors.white, size: 28.w),
            SizedBox(height: 14.h),
            Text(
              'جارٍ التحميل...',
              textAlign: TextAlign.center,
              style: GoogleFonts.tajawal(
                color: const Color(0xFFEEEEEE),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 48.h),
          ],
        ),
      ),
    );
  }
}
