import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/features/Home/presentation/widgets/btn_search_home_widget.dart';
import 'package:workspace/features/Home/presentation/widgets/filter_home_widget.dart';

class HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  final VoidCallback onSearch;
  final int selectedFilter;
  final ValueChanged<int> onFilter;

  HomeHeaderDelegate({
    required this.onSearch,
    required this.selectedFilter,
    required this.onFilter,
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
              padding: EdgeInsets.only(left: 16.w, right: 16),
              child: FilterNormalHomeWidget(
                selectedIndex: selectedFilter,
                onSelect: onFilter,
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
  bool shouldRebuild(covariant HomeHeaderDelegate oldDelegate) =>
      oldDelegate.selectedFilter != selectedFilter;
}
