import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class LoddingDetailsSpace {

Widget get videoLodding =>

Shimmer.fromColors(
  baseColor: const Color(0xFFFAFAFA),
  highlightColor: Colors.grey.shade300,
  child: Container(
    width: double.infinity,
    height: 167.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      color: const Color(0xFFFAFAFA),
    ),
  ),
);


Widget informationLoading() {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 17.h),
        Row(
          children: [
            Container(
              width: 120.w,
              height: 16.h,
              color: Colors.white,
            ),
            SizedBox(width: 8.w),
            Container(
              width: 70.w,
              height: 16.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50.r),
              ),
            ),
            const Spacer(),
            Container(
              width: 16.w,
              height: 16.h,
              color: Colors.white,
            ),
            SizedBox(width: 8.w),
            Container(
              width: 24.w,
              height: 16.h,
              color: Colors.white,
            ),
            Container(
              width: 60.w,
              height: 16.h,
              color: Colors.white,
            ),
          ],
        ),
        SizedBox(height: 24.h),
        Row(
          children: [
            Container(
              width: 18.w,
              height: 18.h,
              color: Colors.white,
            ),
            SizedBox(width: 8.w),
            Container(
              width: 100.w,
              height: 14.h,
              color: Colors.white,
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 18.w,
                  height: 18.h,
                  color: Colors.white,
                ),
                SizedBox(width: 8.w),
                Container(
                  width: 80.w,
                  height: 14.h,
                  color: Colors.white,
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 18.w,
                  height: 18.h,
                  color: Colors.white,
                ),
                SizedBox(width: 8.w),
                Container(
                  width: 100.w,
                  height: 14.h,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 18.w,
                  height: 18.h,
                  color: Colors.white,
                ),
                SizedBox(width: 8.w),
                Container(
                  width: 130.w,
                  height: 14.h,
                  color: Colors.white,
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 18.w,
                  height: 18.h,
                  color: Colors.white,
                ),
                SizedBox(width: 8.w),
                Container(
                  width: 60.w,
                  height: 14.h,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 24.h),
        Container(
          width: 100.w,
          height: 18.h,
          color: Colors.white,
        ),
        SizedBox(height: 8.h),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          title: Container(
            width: 150.w,
            height: 14.h,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

Widget get sectionDetailsSpaceLoading => Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (index) {
                  return Padding(
                    padding: EdgeInsets.only(right: index == 0 ? 0 : 8.w),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: 80.w,
                        height: 36.h,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                    ),
                  );
                }),
              );

Widget buildTextShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(5, (index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Container(
            width: double.infinity,
            height: 14.h,
            color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 8.w),
          ),
        );
      }),
    ),
  );
}

}
