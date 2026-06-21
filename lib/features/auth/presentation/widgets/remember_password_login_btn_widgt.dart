import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workspace/core/styles/app_colors.dart';

class RememberPasswordAndLoginButtonWidgt extends StatelessWidget {
  final VoidCallback onLogin;

  const RememberPasswordAndLoginButtonWidgt({super.key, required this.onLogin});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'تذكرت كلمة المرور',
          style: GoogleFonts.tajawal(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
          ),
        ),
        InkWell(
          onTap: onLogin,
          child: Container(
            height: 37.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: const Color(0xFFF5F5F5),
            ),
            child: Center(
              child: Text(
                'سجّل دخول',
                style: GoogleFonts.tajawal(
                  color: AppColors.primary,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
