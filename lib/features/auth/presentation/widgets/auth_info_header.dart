import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_colors.dart';

/// عنوان رئيسي + وصف، موسّطان (يُستخدمان أعلى محتوى شاشات المصادقة).
class AuthInfoHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthInfoHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Text(
            title,
            style: GoogleFonts.tajawal(
              color: AppColors.primary,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 4.sp),
        Center(
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.tajawal(
              color: const Color(0xFF616161),
              fontSize: 12.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}
