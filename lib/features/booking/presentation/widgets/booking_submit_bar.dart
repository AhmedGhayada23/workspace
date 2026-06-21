import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_colors.dart';

/// الشريط السفلي المشترك لزر إرسال الحجز (طلب الحجز + تأكيد الحجز).
class BookingSubmitBar extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback onTap;

  const BookingSubmitBar({
    super.key,
    required this.label,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: 83.h,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFF9FAFB), width: 1.w),
          boxShadow: const [
            BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.04), offset: Offset(0, -2), blurRadius: 4),
          ],
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(color: AppColors.primary)
              : Container(
                  height: 44.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  margin: EdgeInsets.symmetric(horizontal: 24.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF32B599),
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: GoogleFonts.tajawal(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
