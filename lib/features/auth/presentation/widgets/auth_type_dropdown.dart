import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/theme/text_styles.dart';

/// قائمة منسدلة ثابتة (بلا أنيميشن) لاختيار قسم المستخدم.
class AuthTypeDropdown extends StatelessWidget {
  final List<String> items;
  final String? Function(String?)? validator;
  final void Function(String value) onChanged;

  /// القيمة المختارة مبدئياً (مثلاً نوع المستخدم الحالي عند التعديل).
  final String? initialItem;

  const AuthTypeDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.validator,
    this.initialItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('القسم', style: AppTextStyles.body),
        SizedBox(height: 10.sp),
        CustomDropdown<String>(
          hintText: 'اختر قسم المستخدم',
          closedHeaderPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          items: items,
          initialItem: initialItem,
          validator: validator,
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
          decoration: CustomDropdownDecoration(
            hintStyle: GoogleFonts.tajawal(fontSize: 16.sp, color: const Color(0xFF9E9E9E)),
            headerStyle: GoogleFonts.tajawal(fontSize: 16.sp, fontWeight: FontWeight.bold),
            listItemStyle: GoogleFonts.tajawal(fontSize: 14.sp),
            closedBorderRadius: BorderRadius.circular(50.r),
            expandedBorderRadius: BorderRadius.circular(8.r),
            closedBorder: Border.all(color: const Color(0xFFF5F5F5), width: 1.r),
            expandedBorder: Border.all(color: const Color(0xFFF5F5F5), width: 1.r),
            closedErrorBorder: Border.all(color: const Color(0xFFF5F5F5), width: 1.r),
            closedErrorBorderRadius: BorderRadius.circular(50.r),
            errorStyle: GoogleFonts.tajawal(),
          ),
        ),
        SizedBox(height: 12.h),
      ],
    );
  }
}
