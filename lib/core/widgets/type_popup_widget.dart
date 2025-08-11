import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/animated/animated_dropdown.dart';
import 'package:workspace/features/auth/controllers/sign_in_controller.dart';
import 'package:workspace/features/auth/controllers/sign_up_controller.dart';
import 'package:workspace/utils/validators.dart';

void showCustomPopup(
  BuildContext context,
  Function()? onTap,
) {
  final Map<String, String> userTypes = {
    'طالب': 'student',
    'موظف': 'employee',
    'مستقل': 'independent',
    'شركة': 'company',
  };
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          width: 364,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "اختيار القسم", // استبدل هذا بالنص الذي تريده
                  textAlign: TextAlign.center,
                  style: GoogleFonts.tajawal(
                    color: Color(0xFF1B132A),

                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    height: 1, // يعادل line-height: normal
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "لانشاء حساب جديد من جوجل يرجى اختيار القسم ", // غيّر النص كما تريد
                textAlign: TextAlign.center,
                style: GoogleFonts.tajawal(
                  color: Color(0xFF7A7A7A),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  height: 1,
                ),
              ),
              SizedBox(height: 24.h),
              ...animatedDropdown(
                1,
                null,
                userTypes.keys.toList(), // عرض القيم العربية
                (value) => Validators.required(value),
                (value) {
                  userTypes[value]!; // تخزين القيمة الإنجليزية
                  log('user type :: ${userTypes[value]!}');
                  final signInController = Get.put(SignInController());
                  final signUpController = Get.put(SignUpController());

                  signInController.userType.value = userTypes[value]!;
                  signUpController.userType.value = userTypes[value]!;
                },
              ),
              SizedBox(height: 24.h),
              InkWell(
                onTap: onTap,
                child: Container(
                  height: 44.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Color(0xFF32B599), // يعادل var(--p-1, #32B599)
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "تاكيد", // غير النص حسب الحاجة
                    style: GoogleFonts.tajawal(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
