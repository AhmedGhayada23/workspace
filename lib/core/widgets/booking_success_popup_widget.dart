import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animate_do/animate_do.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/navigation/app_navigator.dart';
import 'package:workspace/core/styles/app_image.dart';


class BookingSuccessPopup extends StatelessWidget {
  const BookingSuccessPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        width: 364.w,
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ZoomIn(
                duration: const Duration(milliseconds: 500),
                child: SvgPicture.asset(AppSvg.congratulationsSvg),
              ),
              SizedBox(height: 8.h),
              FadeInDown(
                duration: const Duration(milliseconds: 600),
                child: Text(
                  'تهانينا!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.tajawal(
                    color: const Color(0xFF1B132A),
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    height: 1.0,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              FadeIn(
                duration: const Duration(milliseconds: 700),
                child: Text(
                  'لقد تمت عملية الحجز بنجاح، ونشكر لك اهتمامك. يرجى الانتظار حتى يتم تأكيد الحجز من قبل فريقنا!',
                  style: GoogleFonts.tajawal(
                    color: const Color(0xFF7A7A7A),
                    fontSize: 14.sp,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    letterSpacing : 1.2
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 24.h),
              BounceInUp(
                duration: const Duration(milliseconds: 800),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop(); // لإغلاق الـ popup
                    sl<AppNavigator>().offAllToHomeTab(1);
                  },
                  child: Container(
                    height: 44.h,
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF32B599),
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Center(
                      child: Text(
                        'عرض حجوزاتي',
                        style: GoogleFonts.tajawal(
                          color: const Color(0xFFFAFAFA),
                          fontSize: 18.sp,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          height: 1.0,
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
    );
  }
}
