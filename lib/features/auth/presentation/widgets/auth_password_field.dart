import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/core/theme/text_styles.dart';
import 'package:workspace/core/widgets/text_field_widget.dart';

/// حقل كلمة مرور ثابت: عنوان + حقل مع زر إظهار/إخفاء.
class AuthPasswordField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscure;
  final VoidCallback onToggle;
  final Iterable<String>? autofillHints;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;

  const AuthPasswordField({
    super.key,
    required this.label,
    required this.controller,
    required this.obscure,
    required this.onToggle,
    this.autofillHints,
    this.textInputAction = TextInputAction.done,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.body),
        SizedBox(height: 10.sp),
        TextFieldWidgets(
          controller: controller,
          hint: '***********',
          autofillHints: autofillHints,
          obscureText: obscure,
          textInputAction: textInputAction,
          validator: validator,
          suffixIcon: IconButton(
            icon: SvgPicture.asset(
              obscure ? AppSvg.eyeslashSvg : AppSvg.eyeSvg,
              color: const Color(0xFF757575),
              width: 24.w,
              height: 24.h,
            ),
            onPressed: onToggle,
          ),
        ),
        SizedBox(height: 12.h),
      ],
    );
  }
}
