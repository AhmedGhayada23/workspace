import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/theme/text_styles.dart';

class SignUpPromptWidget extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final String btuTitle;
  const SignUpPromptWidget({
    required this.title,
    required this.btuTitle,
    this.onTap,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
          title,

            style: GoogleFonts.tajawal(
              color: AppColors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
      
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Container(
              height: 37.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Color.fromARGB(20, 255, 255, 255),
            
              ),
              child: Center(
                child: Text(
              btuTitle,
              style: GoogleFonts.tajawal(
                color: AppColors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                  
              ),
              ),
            ),
            ),
          ),
          
          
        ],
      ),
    );
  }
}
