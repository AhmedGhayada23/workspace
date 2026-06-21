import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';

/// هيدر بزر رجوع + الشعار (لشاشات الاستعادة/الرمز/كلمة المرور الجديدة/التهنئة).
class AuthLogoHeader extends StatelessWidget {
  final VoidCallback onBack;

  const AuthLogoHeader({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: onBack,
            icon: Icon(Icons.arrow_back_rounded, color: AppColors.white, size: 24.r),
          ),
          Center(child: Image.asset(AppImage.logoImage)),
        ],
      ),
    );
  }
}
