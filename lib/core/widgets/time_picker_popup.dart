import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TimePickerPopup extends StatelessWidget {
  final Function(DateTime) onTimeSelected;
  final VoidCallback onContinue;

  const TimePickerPopup({
    super.key,
    required this.onTimeSelected,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'حدد الوقت',
              style: GoogleFonts.tajawal(
                color: Color(0xFF212121),
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              use24hFormat: true,
              onDateTimeChanged: (DateTime newTime) {
                onTimeSelected(newTime);
              },
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3DC39D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'متابعة',
                    style: GoogleFonts.tajawal(
                      color: Color(0xFFFAFAFA),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'إلغاء',
                    style: GoogleFonts.tajawal(
                      color: Color(0xFFF75555),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
