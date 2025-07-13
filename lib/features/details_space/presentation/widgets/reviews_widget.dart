import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:animate_do/animate_do.dart';
import 'package:workspace/features/details_space/data/model/details_space_model.dart'; // استيراد animate_do

class ReviewsWidget extends StatelessWidget {
final List<CustomerRatingAverages> evaluations;
  const ReviewsWidget({super.key,required this.evaluations});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        evaluations.length,
        (index) => FadeInUp(
          // تأثير الأنيميشن
          duration: Duration(milliseconds: 500 + (index * 200)), // توقيت متفاوت
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 16.h),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          evaluations[index].imageUrl ??
                          'https://th.bing.com/th/id/OIP.EFG_2_FQ5ZK0eep1vVQ6fwHaHa?rs=1&pid=ImgDetMain',
                        ), // أو NetworkImage إذا كانت صورة من الإنترنت
                        fit: BoxFit.cover,
                        alignment: Alignment(0, -0.1), // يعادل 0px -3.686px تقريبًا
                      ),

                      color: Color(0xFFE0E0E0),
                    ),
                  ),
                  title: Text(
                    evaluations[index].name ?? '',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.tajawal(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF212121),
                    ),
                  ),
                  subtitle: Text(
                    'عضو منذ ${evaluations[index].createdAt?.split(' ').first}',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.tajawal(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF616161),
                    ),
                  ),
                  trailing: Text(
                    evaluations[index].createdAt?.split(' ').first ?? '',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.tajawal(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF757575),
                      height: 1.4,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: List.generate(
                    (evaluations[index].average ?? 0).floor(),
                    (i) => SvgPicture.asset(AppSvg.starSvg),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                 evaluations[index].message ?? '',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.tajawal(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF171725),
                    height: 1.0.h,
                  ),
                ),
                // SizedBox(height: 8.h),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     SvgPicture.asset(AppSvg.likeSvg),
                //     SizedBox(width: 8.w),
                //     Text(
                //       '1',
                //       style: GoogleFonts.tajawal(
                //         color: Color(0xFF212121),
                //         fontSize: 16.sp,
                //         fontWeight: FontWeight.w500,
                //         height: 1.0,
                //       ),
                //     ),
                //     SizedBox(width: 16.w),
                //     SvgPicture.asset(AppSvg.dislikeSvg),
                //     SizedBox(width: 8.w),
                //     Text(
                //       '0',
                //       style: GoogleFonts.tajawal(
                //         color: Color(0xFF212121),
                //         fontSize: 16.sp,
                //         fontWeight: FontWeight.w500,
                //         height: 1.0,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
