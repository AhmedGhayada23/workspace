import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class LoadingNotifcation {
  Widget buildNotificationShimmer() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 8.h),
    child: Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(

        decoration: BoxDecoration(
          color: Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(4.r),
        ),
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: double.infinity,
              height: 18.h,
              color: Colors.white,
            ),
            SizedBox(height: 8.h),
            Container(
              width: 60.w,
              height: 14.h,
              color: Colors.white,
            ),
            SizedBox(height: 8.h),
            Container(
              width: 120.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}
