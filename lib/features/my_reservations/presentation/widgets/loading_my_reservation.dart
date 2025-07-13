import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class LoadingMyReservation {
  Widget get persistentHeader => Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      width: 80.w,
      height: 36.h,
      decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(20.r)),
    ),
  );

  Widget get cardShimmerMyResevation => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
    child: Container(


      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA), // var(--w-1)
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة المكان
            Container(
              width: 96.w,
              height: 90.h,
              decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(6.r)),
            ),

            // اليسار (محتوى الحجز)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // الاسم والموقع
                  Row(
                    children: [
                      SizedBox(width: 8.w),
                      Container(width: 120.w, height: 16.h, color: Colors.white),
                      Spacer(),
                      // التاريخ
                      Container(width: 60.w, height: 16.h, color: Colors.white),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      SizedBox(width: 8.w),
                      Container(

                        width: 16.w,
                        height: 16.h,
                        color: Colors.white,
                      ),
                      Container(width: 100.w, height: 14.h, color: Colors.white),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  // رقم الحجز والزر
                  Row(
                    children: [
                      SizedBox(width: 8.w),
                      InkWell(
                        onTap: () {
                          // لو كانت هناك وظيفة، يمكنك إضافة الكود هنا.
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(7, 189, 116, 0.12),
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: Row(
                            children: [
                              Container(width: 16.w, height: 16.h,color: Colors.white,),
                              Container(width: 80.w, height: 16.h, color: Colors.white),
                              SizedBox(width: 6.w),
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(width: 60.w, height: 18.h, color: Colors.white),
                      SizedBox(width: 12.w),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
