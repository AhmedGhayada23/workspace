import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/features/my_reservations/data/models/details_resevation_model.dart';

class NonProfitBookingDetailWidget extends StatelessWidget {
  final List<Intervals>? intervals;
  final Room room;
  const NonProfitBookingDetailWidget({super.key, required this.intervals,required this.room});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDetailRow('اسم الفترة', 'الفترة ${intervals?[index].periodTitle ?? ''}'),
              SizedBox(height: 16.h),
              buildDetailRow('الغرفة', room.name ?? ''),
              SizedBox(height: 16.h),
              buildDetailRow('اليوم', intervals?[index].dayTitle ?? ''),
              SizedBox(height: 16.h),
              Row(
                children: [
                  SvgPicture.asset(
                    AppSvg.clockSvg,
                    color: AppColors.black,
                    width: 16.w,
                    height: 16.h,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'متاحة من',
                    style: GoogleFonts.tajawal(
                      color: Color(0xFF757575),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    intervals?[index].availableFrom,
                   // formatTime(intervals?[index].availableFrom ?? ''),
                    style: GoogleFonts.tajawal(
                      color: Color(0xFF424242),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  SvgPicture.asset(
                    AppSvg.clockSvg,
                    color: AppColors.black,
                    width: 16.w,
                    height: 16.h,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'متاحة الى',
                    style: GoogleFonts.tajawal(
                      color: Color(0xFF757575),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    intervals?[index].availableTo,
                   // formatTime(intervals?[index].availableTo ?? ''),
                    style: GoogleFonts.tajawal(
                      color: Color(0xFF424242),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 8.h),
      itemCount: intervals?.length ?? 0,
    );
  }

  Widget buildDetailRow(String title, String value) {
    return Row(
      children: [
        SizedBox(
          width: 100.w,
          child: Text(
            title,
            style: GoogleFonts.tajawal(
              color: Color(0xFF9E9E9E),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.tajawal(
              color: Color(0xFF212121),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

String formatTime(String isoDate) {
  final dateTime = DateTime.parse(isoDate).toLocal();
  final hour = dateTime.hour;
  final minute = dateTime.minute.toString().padLeft(2, '0');
  final suffix = hour >= 12 ? 'م' : 'ص';

  final formattedHour = hour % 12 == 0 ? 12 : hour % 12;
  return '$formattedHour:$minute $suffix';
}

}
