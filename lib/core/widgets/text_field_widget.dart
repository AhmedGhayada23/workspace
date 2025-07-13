import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class TextFieldWidgets extends StatelessWidget {
  final String hint;
  final Widget? icon;
  final Widget? suffixIcon;

  final bool obscureText;
  final bool readOnly;
  final int maxLines;
  final double radius;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType keyboardType;  // إضافة خاصية keyboardType
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final String? Function(String?)? onFieldSubmitted;




  const TextFieldWidgets({
    required this.hint,
    this.obscureText = false,
    this.readOnly = false,
    this.maxLines = 1,
    this.radius = 50,
    this.icon,
    this.suffixIcon,
    this.controller,
    this.focusNode,
    this.autofillHints,
    this.textInputAction,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.keyboardType = TextInputType.text, // تحديد نوع الكيبورد الافتراضي
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
  focusNode: focusNode,
  controller: controller,
  obscureText: obscureText,
  readOnly: readOnly,
  maxLines: maxLines,
  keyboardType: keyboardType,
  autofillHints: autofillHints,
  textInputAction: textInputAction,
  validator: validator,
  onChanged: onChanged,
  onFieldSubmitted: onFieldSubmitted,
  decoration: InputDecoration(
    hintText: hint,
    hintStyle: GoogleFonts.tajawal(
      color: const Color(0xFFBDBDBD), // لون أوضح قليلاً
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
    ),
    suffixIcon: suffixIcon,
    filled: true,
    fillColor: Colors.white,
    prefixIcon: icon,
    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius.r),
      borderSide: BorderSide(
        color: const Color(0xFFF5F5F5),
        width: 1.r,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius.r),
      borderSide: BorderSide(
        color: const Color(0xFFF5F5F5),
        width: 1.r,
      ),
    ),
    errorStyle: GoogleFonts.tajawal(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,

    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius.r),
      borderSide: BorderSide(
        color: const Color(0xFFF5F5F5),
        width: 1.r,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius.r),
      borderSide: BorderSide(
        color: const Color(0xFFF5F5F5),
        width: 1.r,
      ),
    ),
  ),
  style: GoogleFonts.tajawal(
    color: const Color(0xFF212121), // لون أغمق لزيادة الوضوح
    fontSize: 18.sp, // حجم أكبر قليلاً لسهولة القراءة
    fontWeight: FontWeight.w500,
  ),
);

  }
}
