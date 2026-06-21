import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/features/auth/presentation/widgets/auth_type_dropdown.dart';
import 'package:workspace/utils/validators.dart';

/// خريطة الأقسام المعروضة (عربي -> قيمة الخادم).
const Map<String, String> kUserTypes = {
  'طالب': 'student',
  'موظف': 'employee',
  'مستقل': 'independent',
};

/// popup اختيار القسم بعد تسجيل الدخول عبر Google.
/// يستدعي [onConfirm] بقيمة الخادم للقسم المختار.
void showGoogleTypePopup(BuildContext context, void Function(String type) onConfirm) {
  String? selectedType;

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
                  "اختيار القسم",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.tajawal(
                    color: const Color(0xFF1B132A),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "لإنشاء حساب جديد من Google يرجى اختيار القسم",
                textAlign: TextAlign.center,
                style: GoogleFonts.tajawal(
                  color: const Color(0xFF7A7A7A),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 24.h),
              AuthTypeDropdown(
                items: kUserTypes.keys.toList(),
                validator: (value) => Validators.required(value),
                onChanged: (value) => selectedType = kUserTypes[value],
              ),
              SizedBox(height: 24.h),
              InkWell(
                onTap: () {
                  if (selectedType == null) return;
                  Navigator.of(context).pop();
                  onConfirm(selectedType!);
                },
                child: Container(
                  height: 44.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF32B599),
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "تأكيد",
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
