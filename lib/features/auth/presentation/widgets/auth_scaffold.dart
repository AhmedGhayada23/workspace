import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workspace/core/styles/app_colors.dart';

/// الهيكل المشترك لشاشات المصادقة:
/// خلفية خضراء + [header] + الشريط العلوي الصغير + ورقة بيضاء بحواف دائرية تحوي [child].
class AuthScaffold extends StatelessWidget {
  final GlobalKey<FormState>? formKey;
  final Widget header;
  final Widget child;
  final bool scrollable;
  final double topSpacing;

  const AuthScaffold({
    super.key,
    this.formKey,
    required this.header,
    required this.child,
    this.scrollable = false,
    this.topSpacing = 45,
  });

  @override
  Widget build(BuildContext context) {
    Widget body = Container(
      color: AppColors.primary,
      child: Column(
        children: [
          SizedBox(height: topSpacing.h),
          header,
          SizedBox(height: 24.h),
          _TopBar(),
          Expanded(child: _WhiteSheet(scrollable: scrollable, child: child)),
        ],
      ),
    );

    if (formKey != null) {
      body = Form(key: formKey, child: body);
    }

    return Scaffold(backgroundColor: AppColors.white, body: body);
  }
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16.h,
      margin: EdgeInsets.symmetric(horizontal: 35.w),
      decoration: BoxDecoration(
        color: const Color.fromARGB(20, 255, 255, 255),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
    );
  }
}

class _WhiteSheet extends StatelessWidget {
  final Widget child;
  final bool scrollable;

  const _WhiteSheet({required this.child, required this.scrollable});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 32.h),
        child: scrollable ? SingleChildScrollView(child: child) : child,
      ),
    );
  }
}
