import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_image.dart';

/// نافذة سفلية لاختيار المحافظة. تستدعي [onApply] بمعرّف المحافظة المختارة.
void showProvinceFilterSheet(
  BuildContext context, {
  required Map<String, int> provinces,
  required int currentId,
  required ValueChanged<int> onApply,
}) {
  final entries = provinces.entries.toList();
  int selected = entries.indexWhere((e) => e.value == currentId);
  if (selected < 0) selected = 0;

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
    ),
    backgroundColor: const Color(0xFFFAFAFA),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setSheetState) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'تصفية',
                  style: GoogleFonts.tajawal(
                    color: const Color(0xFF616161),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  height: 300.h,
                  child: ListView.builder(
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      final isSelected = selected == index;
                      return InkWell(
                        onTap: () => setSheetState(() => selected = index),
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
                                    color: isSelected
                                        ? const Color(0xFF32B599)
                                        : const Color(0xFFD6F0EB),
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: isSelected
                                    ? const DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: Color(0xFF32B599),
                                          shape: BoxShape.circle,
                                        ),
                                      )
                                    : null,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                entries[index].key,
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
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    onApply(entries[selected].value);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 44.h,
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF32B599),
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppSvg.settingSvg, width: 24.w, height: 24.h),
                        SizedBox(width: 8.w),
                        Text(
                          'تصفية الان',
                          style: GoogleFonts.tajawal(
                            color: const Color(0xFFFAFAFA),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
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
