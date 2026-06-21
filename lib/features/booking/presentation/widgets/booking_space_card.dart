import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/features/details_space/data/model/details_space_model.dart';

/// بطاقة ملخّص المساحة في شاشة تأكيد الحجز.
class BookingSpaceCard extends StatelessWidget {
  final Spaces space;

  const BookingSpaceCard({super.key, required this.space});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 96.w,
            height: 90.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  space.mainImageUrl ??
                      'https://th.bing.com/th/id/OIP.h6tPbr6dD70MsHJaDT0XJgHaJ4?rs=1&pid=ImgDetMain',
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(6.r),
              color: const Color(0xFFD9D9D9),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        space.company?.name ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.tajawal(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF212121),
                        ),
                      ),
                    ),
                    Text(
                      DateFormat('dd-MM-yyyy').format(DateTime.now()),
                      style: GoogleFonts.tajawal(
                        fontSize: 12.sp,
                        color: const Color(0xFF757575),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    SizedBox(width: 8.w),
                    SvgPicture.asset(AppSvg.locationSvg,
                        width: 16.w, height: 16.h, color: const Color(0xFF757575)),
                    Expanded(
                      child: Text(
                        space.address ?? '-',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.tajawal(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF757575),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    const Spacer(),
                    Text(
                      '#${space.createdAt?.split('-').first}099${space.id}',
                      style: GoogleFonts.tajawal(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF212121),
                      ),
                    ),
                    SizedBox(width: 12.w),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
