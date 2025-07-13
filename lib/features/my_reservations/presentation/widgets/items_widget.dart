import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';

class NoItemsWidget extends StatelessWidget {
  const NoItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 150.h,),
          Center(child: ElasticInDown(child: SvgPicture.asset(AppSvg.documentTextSvg,width: 93.w,height: 93.h,color: Color(0xFF9E9E9E),))),
          SizedBox(height: 16.h,),
          ZoomIn(
            child: Text(
              'لا يوجد حجوزات',
              textAlign: TextAlign.center,
              style: GoogleFonts.tajawal(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Color(0xFFBDBDBD),
              ),
            ),
          )

        ],
      );
  }
}