import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// شارة أيقونة بخلفية متدرّجة خفيفة (تُستخدم أعلى شاشات الاستعادة/الرمز/كلمة المرور).
class AuthIconBadge extends StatelessWidget {
  final String svgAsset;
  final double height;

  const AuthIconBadge({super.key, required this.svgAsset, this.height = 60});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height.h,
        width: 60.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromRGBO(50, 181, 153, 0.08),
              Color.fromRGBO(91, 196, 173, 0.08),
            ],
          ),
        ),
        child: Center(child: SvgPicture.asset(svgAsset)),
      ),
    );
  }
}
