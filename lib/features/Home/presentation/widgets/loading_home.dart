import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmerView {
  // ✅ AppBar كـ ويدجت مستقل
  Widget get appBar => SliverAppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(color: Colors.white),
          title: Padding(
            padding: EdgeInsets.only(
                top: MediaQueryData.fromView(WidgetsBinding.instance.window)
                    .padding
                    .top),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: CircleAvatar(
                      radius: 25.r,
                      backgroundColor: Colors.grey.shade300,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: 100.w,
                          height: 14.h,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: 60.w,
                          height: 12.h,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget get persistentHeader => SliverPersistentHeader(
        pinned: true,
        delegate: ShimmerHeaderDelegate(),
      );

  Widget get sectionHeader => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // شيمر لعنوان "المساحات الجديدة"
              Container(
                height: 20.h,
                width: 120.w,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              // شيمر لنص "مشاهدة المزيد"
              Container(
                height: 16.h,
                width: 80.w,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ],
          ),
        ),
      );

  Widget spaceCard({
    double? width,
    double? height,
    double? borderRadius,
    EdgeInsets? margin,
  }) =>
      Container(
        width: width ?? 310.w,
        height: height ?? 274.h,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
        margin: margin ?? EdgeInsets.only(left: 16.w, bottom: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Column(
            children: [
              // صورة المكان
              Container(
                height: 167.h,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    height: 33.h,
                    width: 103.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              // اسم المكان + التقييم
              Row(
                children: [
                  Container(
                    width: 140.w,
                    height: 16.h,
                    color: Colors.white,
                  ),
                  Spacer(),
                  Container(
                    width: 60.w,
                    height: 16.h,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(height: 6.h),

              // الموقع + الوقت
              Row(
                children: [
                  Container(
                    width: 120.w,
                    height: 14.h,
                    color: Colors.white,
                  ),
                  Spacer(),
                  Container(
                    width: 100.w,
                    height: 14.h,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(height: 6.h),

              // رقم الهاتف + البريد
              Row(
                children: [
                  Container(
                    width: 90.w,
                    height: 14.h,
                    color: Colors.white,
                  ),
                  SizedBox(width: 24.w),
                  Expanded(
                    child: Container(
                      height: 14.h,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

class ShimmerHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      color: Colors.white,
      child: SizedBox(
        height: maxExtent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),

            /// Shimmer لزر البحث
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  height: 48.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ),

            SizedBox(height: 12.h),

            /// Shimmer للفلاتر
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 150.0.h;

  @override
  double get minExtent => 150.0.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
