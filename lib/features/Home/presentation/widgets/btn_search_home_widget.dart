import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_image.dart';

class BtnSearchHomeWidget extends StatelessWidget {
  final VoidCallback? onTap;

  const BtnSearchHomeWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 44.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          border: Border.all(width: 1.w, color: const Color(0xFFF5F5F5)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SvgPicture.asset(AppSvg.circumSearchSvg, color: const Color(0xFFBDBDBD)),
              SizedBox(width: 8.w),
              Text(
                'ابحث عن مساحات العمل...',
                style: GoogleFonts.tajawal(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFBDBDBD),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
