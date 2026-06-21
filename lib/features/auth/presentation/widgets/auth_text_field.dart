import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workspace/core/theme/text_styles.dart';
import 'package:workspace/core/widgets/text_field_widget.dart';

/// حقل نصّي ثابت (بلا أنيميشن): عنوان + حقل مع أيقونة اختيارية.
class AuthTextField extends StatelessWidget {
  final String label;
  final String hint;
  final String? iconAsset;
  final TextInputType keyboardType;
  final Iterable<String>? autofillHints;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    this.iconAsset,
    this.keyboardType = TextInputType.text,
    this.autofillHints,
    this.textInputAction = TextInputAction.next,
    this.focusNode,
    this.controller,
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
          focusNode: focusNode,
          keyboardType: keyboardType,
          autofillHints: autofillHints,
          hint: hint,
          textInputAction: textInputAction,
          validator: validator,
          icon: iconAsset != null
              ? IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(iconAsset!,
                      width: 24.w, height: 24.h, color: const Color(0xFF757575)),
                )
              : null,
        ),
        SizedBox(height: 12.h),
      ],
    );
  }
}
