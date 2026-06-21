import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_colors.dart';

/// فلتر الرئيسية — يتلقّى التحديد والـ callback من الـ Cubit (بلا GetX).
class FilterNormalHomeWidget extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const FilterNormalHomeWidget({
    super.key,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(3, (index) {
          final isSelected = selectedIndex == index;
          return Expanded(
            child: InkWell(
              onTap: () => onSelect(index),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                height: double.infinity,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(50.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  index == 0 ? 'الكل' : index == 1 ? 'الغير ربحية' : 'الربحية',
                  style: GoogleFonts.tajawal(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? AppColors.white : AppColors.black,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

