import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workspace/core/theme/text_styles.dart';
import 'package:workspace/core/widgets/text_field_widget.dart';




List<Widget> animatedField(int index, String label, String hint, String? iconAsset ,TextInputType keyboardType,Iterable<String>? autofillHints,TextInputAction textInputAction,FocusNode?  focusNode,TextEditingController? controller,final String? Function(String?)? validator) {
    final delay = Duration(milliseconds: 300 + index * 100);
    return [
      FadeInUp(
        delay: delay,
        duration: Duration(milliseconds: 600),
        child: Text(label, style: AppTextStyles.body),
      ),
      SizedBox(height: 10.sp),
      FadeInUp(
        delay: delay + Duration(milliseconds: 100),
        duration: Duration(milliseconds: 600),
        child: TextFieldWidgets(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType ,
          autofillHints: autofillHints,
          hint: hint,
          textInputAction: textInputAction,
          validator: validator,
          icon:iconAsset != null ? IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(iconAsset, width: 24.w, height: 24.h, color: Color(0xFF757575)),
          ) :null,
        ),
      ),
      SizedBox(height: 10.sp),
    ];
  }





