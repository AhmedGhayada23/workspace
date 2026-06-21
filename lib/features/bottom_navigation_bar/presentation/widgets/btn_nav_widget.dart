import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/features/bottom_navigation_bar/presentation/cubit/btn_nav_cubit.dart';

class BtnNavWidget extends StatelessWidget {
  final List<BtnTab> tabs;
  final int activeIndex;
  final Function(int) onTap;

  const BtnNavWidget({
    required this.tabs,
    required this.activeIndex,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: AnimatedBottomNavigationBar.builder(
        backgroundColor: AppColors.white,
        height: 83.h,
        elevation: 1,
        itemCount: tabs.length,
        gapLocation: GapLocation.none,
        tabBuilder: (int index, bool isActive) {
          final tab = tabs[index];
          final color = isActive ? const Color(0xFF32B599) : const Color(0xFF66707A);
          return Center(
            child: Container(
              height: 45.h,
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: isActive
                  ? BoxDecoration(
                      color: const Color.fromRGBO(214, 240, 235, 0.5),
                      borderRadius: BorderRadius.circular(20.r),
                    )
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(tab.image, width: 24.w, height: 24.h, color: color),
                  SizedBox(width: 4.w),
                  Text(
                    tab.name,
                    style: GoogleFonts.tajawal(
                      color: color,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        activeIndex: activeIndex,
        leftCornerRadius: 0.r,
        rightCornerRadius: 0.r,
        onTap: onTap,
      ),
    );
  }
}
