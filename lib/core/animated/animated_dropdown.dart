import 'package:animate_do/animate_do.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/theme/text_styles.dart';



 List<Widget> animatedDropdown(int index,String? initialItem,List<String>? items,String? Function(String?)? validator,dynamic Function(dynamic T)? onChanged) {
    final delay = Duration(milliseconds: 300 + index * 100);
    return [
      FadeInUp(
        delay: delay,
        duration: Duration(milliseconds: 600),
        child: Text('sction'.tr, style: AppTextStyles.body),
      ),
      SizedBox(height: 10.sp),
      FadeInUp(
        delay: delay + Duration(milliseconds: 100),
        duration: Duration(milliseconds: 600),
        child: CustomDropdown(
          hintText: 'اختر قسم المستخدم',
          closedHeaderPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          initialItem: initialItem,

          decoration: CustomDropdownDecoration(

            hintStyle: GoogleFonts.tajawal(fontSize: 16.sp, color: Color(0xFF9E9E9E)),
            headerStyle: GoogleFonts.tajawal(fontSize: 16.sp, fontWeight: FontWeight.bold),
            listItemStyle: GoogleFonts.tajawal(fontSize: 14.sp),
            closedBorderRadius: BorderRadius.circular(50.r),
            expandedBorderRadius: BorderRadius.circular(8.r),
            closedBorder: Border.all(color: Color(0xFFF5F5F5), width: 1.r),
            expandedBorder: Border.all(color: Color(0xFFF5F5F5), width: 1.r),
            closedErrorBorder: Border.all(color: Color(0xFFF5F5F5), width: 1.r),
            closedErrorBorderRadius:  BorderRadius.circular(50.r),
            errorStyle: GoogleFonts.tajawal(),
          ),
          items: items,
          validator: validator,
          onChanged: onChanged,
        ),
      ),
      SizedBox(height: 10.sp),
    ];
  }
