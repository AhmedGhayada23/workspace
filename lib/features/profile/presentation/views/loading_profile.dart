import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class LoadingProfile {
  Widget get cartProfileLoading => Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      height: 82.h,
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Center(
        child: ListTile(
          leading: Container(
            width: 58.w,
            height: 58.h,
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          ),
          title: Container(width: 120.w, height: 16.h, color: Colors.white),
          subtitle: Container(
            width: 160.w,
            height: 14.h,
            margin: EdgeInsets.only(top: 4.h),
            color: Colors.white,
          ),
          trailing: Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          ),
        ),
      ),
    ),
  );
}
