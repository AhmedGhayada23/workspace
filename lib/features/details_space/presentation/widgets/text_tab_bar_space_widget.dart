
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TextTabBarSpaceWidget extends StatelessWidget{
  final String? text;
 const TextTabBarSpaceWidget({this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: TextAlign.right,
      style: GoogleFonts.tajawal(
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
      ),
    );
  }
}