import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/navigation/app_navigator.dart';

/// نافذة تطلب تسجيل الدخول (للزائر عند محاولة إجراء يتطلّب حساباً).
class LoginRequiredPopup extends StatelessWidget {
  const LoginRequiredPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      backgroundColor: const Color(0xFFFAFAFA),
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // أيقونة داخل دائرة بلون العلامة
            Container(
              width: 80.r,
              height: 80.r,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE3F4F0),
              ),
              child: Text(
                '🔒',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 38.sp),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'تسجيل الدخول مطلوب',
              textAlign: TextAlign.center,
              style: GoogleFonts.tajawal(
                color: const Color(0xFF1B132A),
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'يجب تسجيل الدخول أو إنشاء حساب أولاً لتتمكّن من إتمام الحجز.',
              textAlign: TextAlign.center,
              style: GoogleFonts.tajawal(
                color: const Color(0xFF7A7A7A),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
            SizedBox(height: 24.h),
            // زر تسجيل الدخول
            SizedBox(
              width: double.infinity,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  sl<AppNavigator>().offAllToSignIn();
                },
                child: Container(
                  height: 44.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFF32B599),
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  child: Text(
                    'تسجيل الدخول',
                    style: GoogleFonts.tajawal(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            // زر لاحقاً
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'لاحقاً',
                style: GoogleFonts.tajawal(
                  color: const Color(0xFF9E9E9E),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// يعرض [LoginRequiredPopup].
Future<void> showLoginRequiredPopup(BuildContext context) {
  return showDialog(
    context: context,
    builder: (_) => const LoginRequiredPopup(),
  );
}
