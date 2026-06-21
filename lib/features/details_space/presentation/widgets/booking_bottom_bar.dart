import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_colors.dart';

/// الشريط السفلي لزر "احجز الان".
class BookingBottomBar extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onTap;

  const BookingBottomBar({super.key, required this.isLoading, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFF9FAFB), width: 1.w),
        boxShadow: const [
          BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.04), offset: Offset(0, -2), blurRadius: 4),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: isLoading ? null : onTap,
            child: isLoading
                ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                : Container(
                    height: 44.h,
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF32B599),
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Center(
                      child: Text(
                        'احجز الان',
                        style: GoogleFonts.tajawal(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

/// نافذة اختيار نوع الحجز (مدفوع/مجاني).
/// تستدعي [onPaid] أو [onFree] بحسب اختيار المستخدم عند التأكيد.
void showBookingTypeSheet(
  BuildContext context, {
  required VoidCallback onPaid,
  required VoidCallback onFree,
}) {
  int selected = 1;
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
    ),
    backgroundColor: const Color(0xFFFAFAFA),
    builder: (sheetContext) {
      return StatefulBuilder(
        builder: (sheetContext, setSheetState) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'نوع الحجز',
                  style: GoogleFonts.tajawal(
                    color: const Color(0xFF616161),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 24.h),
                for (int index = 0; index < 2; index++)
                  _BookingTypeOption(
                    label: index == 0 ? 'مدفوع - اشتراكات' : 'مجاني - غير ربحي',
                    selected: selected == index,
                    onTap: () => setSheetState(() => selected = index),
                  ),
                InkWell(
                  onTap: () {
                    Navigator.pop(sheetContext);
                    selected == 0 ? onPaid() : onFree();
                  },
                  child: Container(
                    height: 44.h,
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF32B599),
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Center(
                      child: Text(
                        'احجز الان',
                        style: GoogleFonts.tajawal(
                          color: const Color(0xFFFAFAFA),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

class _BookingTypeOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _BookingTypeOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        child: Row(
          children: [
            Container(
              width: 24.w,
              height: 24.h,
              padding: EdgeInsets.all(2.r),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: selected ? const Color(0xFF32B599) : const Color(0xFFD6F0EB),
                ),
                shape: BoxShape.circle,
              ),
              child: selected
                  ? const DecoratedBox(
                      decoration: BoxDecoration(color: Color(0xFF32B599), shape: BoxShape.circle),
                    )
                  : null,
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: GoogleFonts.tajawal(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF000000),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
