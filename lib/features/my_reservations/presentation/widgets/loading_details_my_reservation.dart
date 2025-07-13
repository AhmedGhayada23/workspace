import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class LoadingDetailsMyReservation {
Widget buildShimmerPeriodDetails() {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // سطر 1
          _buildShimmerRow(),
          SizedBox(height: 16.h),

          // سطر 2
          _buildShimmerRow(),
          SizedBox(height: 16.h),

          // سطر 3
          _buildShimmerRow(),
          SizedBox(height: 16.h),

          // سطر الوقت
          Row(
            children: [
              _buildCircleIcon(),
              SizedBox(width: 8.w),
              _buildLine(width: 50.w, height: 12.h),
              SizedBox(width: 8.w),
              _buildLine(width: 40.w, height: 16.h),
              SizedBox(width: 16.w),
              _buildCircleIcon(),
              SizedBox(width: 8.w),
              _buildLine(width: 50.w, height: 12.h),
              SizedBox(width: 8.w),
              _buildLine(width: 40.w, height: 16.h),
            ],
          ),
        ],
      ),
    ),
  );
}
// عنصر سطر من عنصرين (مثل: "اسم الفترة" - "الفترة الصباحية")
Widget _buildShimmerRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _buildLine(width: 80.w, height: 14.h),
      _buildLine(width: 100.w, height: 14.h),
    ],
  );
}

// عنصر خط رمادي يمثل نص
Widget _buildLine({required double width, required double height}) {
  return Container(
    width: width,
    height: height,
    color: Colors.white,
  );
}

// دائرة صغيرة تمثل الأيقونات
Widget _buildCircleIcon() {
  return Container(
    width: 16.w,
    height: 16.h,
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
    ),
  );
}
}
