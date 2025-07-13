import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class RememberMeAndForgotPasswordWidget extends StatelessWidget {
  final bool isChecked;
  final Function(bool?) onChanged;
  final VoidCallback onForgotPassword;

  const RememberMeAndForgotPasswordWidget({
    super.key,
    required this.isChecked,
    required this.onChanged,
    required this.onForgotPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Remember Me
        Row(
          children: [
            Checkbox(
              value: isChecked,
              onChanged: onChanged,
              activeColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(width: 2.w),
            Text(
              'remember'.tr,
              style:  GoogleFonts.tajawal(fontSize: 14.sp),
            ),
          ],
        ),
        // Forgot Password
        GestureDetector(
          onTap: onForgotPassword,
          child: Text(
            'forgot_password'.tr,
            style: GoogleFonts.tajawal(
              color: Colors.redAccent,
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }
}
