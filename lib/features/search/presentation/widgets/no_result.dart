import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_image.dart';

class NoResult extends StatelessWidget {
  final String text;
  const NoResult({
    super.key,
    this.text = 'لم نتمكن من العثور على أي نتيجة',
  });

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      child: Column(
        children: [
          SvgPicture.asset(AppSvg.noSearchSvg),
          SizedBox(height: 16.h),
          Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.tajawal(
              color: Color(0xFFBDBDBD), // تحويل الكود من # إلى 0xFF
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }
}
