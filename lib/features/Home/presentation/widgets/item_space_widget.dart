import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/utils/routing.dart';

class ItemSpaceWidget extends StatelessWidget {
  final int id;
  final String image;
  final String typeTitle;
  final String nameCompany;
  final String ratingCount;
  final String ratingAverage;
  final String address;
  final String available;
  final String mobile;
  final String email;

  const ItemSpaceWidget({
    super.key,
    required this.id,
    required this.image,
    required this.typeTitle,
    required this.nameCompany,
    required this.ratingCount,
    required this.ratingAverage,
    required this.address,
    required this.available,
    required this.mobile,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(AppRouting.detailsView, arguments: id),
      child: Container(
        width: 310.w,
        padding: EdgeInsets.all(8.w),

        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6.r),
                  child: CachedNetworkImage(

                    imageUrl: image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 167.h,
                    placeholder:
                        (context, url) => Center(
                          child: Image.asset(AppImage.logoImage, color: AppColors.primary),
                        ),
                    errorWidget:
                        (context, url, error) => Center(
                          child: Image.asset(AppImage.logoImage, color: AppColors.primary),
                        ),
                  ),
                ),
                Positioned(
                  right: 1,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    height: 33.h,
                    width: 103.w,
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      color:image == '' ?Colors.white : Color(0xFFFAFAFA),
                    ),
                    child: Center(
                      child: Text(
                        typeTitle,
                        style: GoogleFonts.tajawal(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF32B599),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),
 Row(
  crossAxisAlignment: CrossAxisAlignment.baseline,
  textBaseline: TextBaseline.alphabetic,
  children: [
    Expanded(
      child: Text(
        nameCompany,
        style: GoogleFonts.tajawal(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF212121),
        ),
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.right,
      ),
    ),

    Baseline(
      baseline: 20.sp,
      baselineType: TextBaseline.alphabetic,
      child: SvgPicture.asset(
        AppSvg.starSvg,
        height: 20.h,
        width: 20.h,
      ),
    ),

    SizedBox(width: 4.w),

    Baseline(
      baseline: 14.sp,
      baselineType: TextBaseline.alphabetic,
      child: Text(
        ratingCount,
        style: GoogleFonts.tajawal(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF171725),
        ),
      ),
    ),

    SizedBox(width: 4.w),

    Baseline(
      baseline: 12.sp,
      baselineType: TextBaseline.alphabetic,
      child: Text(
        '($ratingAverage مقيم)',
        style: GoogleFonts.tajawal(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF66707A),
        ),
      ),
    ),
  ],
),



            SizedBox(height: 6.h),
            Row(
              children: [
                SvgPicture.asset(
                  AppSvg.locationSvg,
                  width: 20.w,
                  height: 20.h,
                  color: const Color(0xFF757575),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    address,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.tajawal(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF757575),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                SvgPicture.asset(
                  AppSvg.clockSvg,
                  width: 20.w,
                  height: 20.h,
                  color: const Color(0xFF757575),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    available,
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
            SizedBox(height: 6.h),
            Row(
              children: [
                SvgPicture.asset(
                  AppSvg.mdiPhoneOutlineSvg,
                  width: 20.w,
                  height: 20.h,
                  color: const Color(0xFF757575),
                ),
                SizedBox(width: 4.w),
                Text(
                  mobile,
                  textDirection: TextDirection.ltr,
                  style: GoogleFonts.tajawal(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF757575),
                  ),
                ),
                SizedBox(width: 24.w),
                SvgPicture.asset(
                  AppSvg.smsSvg,
                  width: 20.w,
                  height: 20.h,
                  color: const Color(0xFF757575),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    email,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.tajawal(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF757575),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
