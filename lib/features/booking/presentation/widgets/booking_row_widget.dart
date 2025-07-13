import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingRowWidget extends StatelessWidget {
  final String title;
  final String value;

  const BookingRowWidget({
    super.key,
    required this.title,
    required this.value,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF9E9E9E),
              )),
          Text(value,
              style: GoogleFonts.tajawal(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF424242),
              )),
        ],
      ),
    );
  }
}