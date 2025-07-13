import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_image.dart';

class InformationAboutSpaceWidget extends StatelessWidget {
  final String nameSpace;
  final String typeTitle;
  final String ratingCount;
  final String ratingAverage;
  final String address;
  final String available;
  final String mobile;
  final String eamil;
  final String customersCount;
  final String nameCompany;
  final String imageCompany;

  const InformationAboutSpaceWidget({
    super.key,
    required this.nameSpace,
    required this.typeTitle,
    required this.ratingCount,
    required this.ratingAverage,
    required this.address,
    required this.available,
    required this.mobile,
    required this.eamil,
    required this.customersCount,
    required this.nameCompany,
    required this.imageCompany,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        SizedBox(height: 17.h),
        Row(
          children: [
            FadeInUp(
              duration: Duration(milliseconds: 600),
              child: Text(
                nameSpace,
                style: GoogleFonts.tajawal(
                  color: const Color(0xFF212121),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            FadeInUp(
              duration: Duration(milliseconds: 700),
              child: Container(
                padding: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  color: const Color(0xFF32B599),
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Center(
                  child: Text(
                    'مساحة $typeTitle',
                    style: GoogleFonts.tajawal(
                      color: const Color(0xFFFAFAFA),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            FadeInUp(
              duration: Duration(milliseconds: 800),
              child: Baseline(
                     baseline: 20.r,
              baselineType: TextBaseline.alphabetic,
                child: SvgPicture.asset(
                  AppSvg.starSvg,
                  width: 20.w,

                  height: 20.h,
                  )),
            ),
            SizedBox(width: 4.w),
            FadeInUp(
              duration: Duration(milliseconds: 900),
              child: Baseline(
                     baseline: 14.r,
              baselineType: TextBaseline.alphabetic,
                child: Text(
                  ratingCount,
                  style: GoogleFonts.tajawal(
                    color: const Color(0xFF171725),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Baseline(
              baseline: 12.r,
              baselineType: TextBaseline.alphabetic,
              child: Text(
                '($ratingAverage مقيم)',
                style: GoogleFonts.tajawal(
                  color: const Color(0xFF66707A),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h),
        FadeInLeft(
          duration: Duration(milliseconds: 1000),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              SvgPicture.asset(
                AppSvg.locationSvg,
                width: 18.w,
                height: 18.h,
                color: Color(0xFF616161),
              ),
              SizedBox(width: 8.w),
              Text(
                address, // استبدل هذا بالنص الذي تريده
                overflow: TextOverflow.ellipsis,

                textAlign: TextAlign.right,
                style: GoogleFonts.tajawal(
                  color: Color(0xFF616161), // اللون المستخرج من var(--b-3)
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  height: 1.0.h, // يعادل line-height: normal
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // clock
            FadeInRight(
              duration: Duration(milliseconds: 1100),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  SvgPicture.asset(
                    AppSvg.clockSvg,
                    width: 18.w,
                    height: 18.h,
                    color: Color(0xFF616161),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    available, // استبدل هذا بالنص الذي تريده
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.tajawal(
                      color: Color(0xFF616161), // اللون المستخرج من var(--b-3)
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      height: 1.0.h, // يعادل line-height: normal
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            // phone
            FadeInLeft(
              duration: Duration(milliseconds: 1200),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  SvgPicture.asset(
                    AppSvg.mdiPhoneOutlineSvg,
                    width: 18.w,
                    height: 18.h,
                    color: Color(0xFF616161),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    textDirection: TextDirection.ltr,
                    overflow: TextOverflow.ellipsis,

                    mobile, // استبدل هذا بالنص الذي تريده
                    textAlign: TextAlign.right,
                    style: GoogleFonts.tajawal(
                      color: Color(0xFF616161), // اللون المستخرج من var(--b-3)
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      height: 1.0.h, // يعادل line-height: normal
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // email
            FadeInLeft(
              duration: Duration(milliseconds: 1300),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  SvgPicture.asset(
                    AppSvg.smsSvg,
                    width: 18.w,
                    height: 18.h,
                    color: Color(0xFF616161),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    eamil, // استبدل هذا بالنص الذي تريده
                    textAlign: TextAlign.right,
                    style: GoogleFonts.tajawal(
                      color: Color(0xFF616161), // اللون المستخرج من var(--b-3)
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      height: 1.0.h, // يعادل line-height: normal
                    ),
                  ),
                ],
              ),
            ),

            // users
            FadeInLeft(
              duration: Duration(milliseconds: 1400),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  SvgPicture.asset(
                    AppSvg.usersSvg,
                    width: 18.w,
                    height: 18.h,
                    color: Color(0xFF616161),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '$customersCount مشترك', // استبدل هذا بالنص الذي تريده
                    textAlign: TextAlign.right,
                    style: GoogleFonts.tajawal(
                      color: Color(0xFF616161), // اللون المستخرج من var(--b-3)
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      height: 1.0.h, // يعادل line-height: normal
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 24.h),
        FadeInRight(
          duration: Duration(milliseconds: 1300),
          child: Text(
            'مدير المساحة',
            textAlign: TextAlign.right,
            style: GoogleFonts.tajawal(
              color: Color(0xFF32B599),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        FadeInUp(
          duration: Duration(milliseconds: 1400),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
                radius: 25.r,
                backgroundColor: Color(0xFFE0E0E0),
                child: ClipOval(
                  child: CachedNetworkImage(
                        imageUrl: imageCompany,
                        fit: BoxFit.cover,

                        placeholder: (context, url) =>  Image.network('https://mobile.spaces.areisto.com/themes/Falcon/v3.22.0/assets/img/team/avatar.png'),
                        errorWidget: (context, url, error) => Image.network('https://mobile.spaces.areisto.com/themes/Falcon/v3.22.0/assets/img/team/avatar.png'),
                      ),
                ),
                // NetworkImage(
                //     controller.profileData.listProileData.value?.data?.user?.personalImageUrl ??
                //   'https://mobile.spaces.areisto.com/themes/Falcon/v3.22.0/assets/img/team/avatar.png',
                // ),
              ),
            title: Text(
              nameCompany,
              style: GoogleFonts.tajawal(
                color: Color(0xFF212121),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
