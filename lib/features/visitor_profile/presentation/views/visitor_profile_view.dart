import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/navigation/app_navigator.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/features/profile/presentation/widgets/item_profile_widget.dart';

class VisitorProfileView extends StatelessWidget {
  const VisitorProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = sl<AppNavigator>();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            children: [
              Container(
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
                      padding: EdgeInsets.all(14.r),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFE3F4F0),
                      ),
                      child: SvgPicture.asset(
                        AppSvg.profileSvg,
                        colorFilter:
                            const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                      ),
                    ),
                    title: Text(
                      'مرحبا بيك , كزائر',
                      textAlign: TextAlign.right,
                      style: GoogleFonts.tajawal(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF212121),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              ItemProfileWidget(
                svg: AppSvg.exportSvg,
                iconColor: const Color(0xFF000000),
                textColor: const Color(0xFF000000),
                text: 'تسجيل دخول',
                showIcon: false,
                onTap: nav.offAllToSignIn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
