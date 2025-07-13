// core/theme/text_styles.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_colors.dart';

class AppTextStyles {
  static final heading = GoogleFonts.tajawal(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static final body = GoogleFonts.tajawal(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );

  static final caption = GoogleFonts.tajawal(
    fontSize: 12.sp,
    color: AppColors.grayText,
  );
}
