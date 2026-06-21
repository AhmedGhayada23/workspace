import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/features/Home/presentation/widgets/btn_search_home_widget.dart';
import 'package:workspace/features/Home/presentation/widgets/filter_home_widget.dart';

class AllSpaceHeaderDelegate extends SliverPersistentHeaderDelegate {
  final VoidCallback onSearch;
  final int selectedFilter;
  final ValueChanged<int> onFilter;
  final VoidCallback onOpenProvince;

  AllSpaceHeaderDelegate({
    required this.onSearch,
    required this.selectedFilter,
    required this.onFilter,
    required this.onOpenProvince,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      color: AppColors.white,
      child: SizedBox(
        height: maxExtent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: BtnSearchHomeWidget(onTap: onSearch),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: FilterNormalHomeWidget(
                      selectedIndex: selectedFilter,
                      onSelect: onFilter,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  InkWell(
                    onTap: onOpenProvince,
                    child: Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: const BoxDecoration(
                        color: Color(0xFF32B599),
                        shape: BoxShape.circle,
                      ),
                      child: Center(child: SvgPicture.asset(AppSvg.settingSvg)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 150.0.r;

  @override
  double get minExtent => 150.0.r;

  @override
  bool shouldRebuild(covariant AllSpaceHeaderDelegate oldDelegate) =>
      oldDelegate.selectedFilter != selectedFilter;
}
