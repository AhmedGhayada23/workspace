import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_colors.dart';

class ButtonLoginWidget extends StatelessWidget {
  final String text;
  final Function()? onTap;
  const ButtonLoginWidget({
    required this.text,
    this.onTap,
    super.key});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
      color: AppColors.primary,
        borderRadius: BorderRadius.circular(50.r),
      
        ),
        child: Center(
      child: Text(text,style: GoogleFonts.tajawal(
        color: AppColors.white,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      ),),
        ),
      ),
    );
  }
}