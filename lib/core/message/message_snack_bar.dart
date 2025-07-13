import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_colors.dart';

enum SnackBarType { success, error, warning,noConnection,successInterNet}

void showCustomSnackBar(BuildContext context, String message, SnackBarType type) {
  // تحديد الأيقونة واللون بناءً على النوع
  IconData icon;
  Color iconColor;
  Color backgroundColor;

  switch (type) {
    case SnackBarType.success:
      icon = Icons.check_circle;
      iconColor = Colors.green;
      backgroundColor = Colors.black; // اختر اللون المناسب للنجاح
      break;

    case SnackBarType.successInterNet : 
     icon = Icons.wifi;
     iconColor = Colors.green;
     backgroundColor  = Colors.black;
     break;

    case SnackBarType.error:
      icon = Icons.error;
      iconColor = Colors.red; // اختر اللون المناسب للفشل
     backgroundColor = Colors.black; 
      break;
    case SnackBarType.warning:
      icon = Icons.warning;
      iconColor = Colors.orange; // اختر اللون المناسب للتحذير
     backgroundColor = Colors.black; 
      break;
     case SnackBarType.noConnection:
      icon = Icons.signal_wifi_off;
      iconColor = Colors.red;  // اللون الأحمر للتحذير من انقطاع الاتصال
     backgroundColor = Colors.black; 
      break;  
  }

  final snackBar = SnackBar(
    content: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // إضافة التمويه
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.white,
              radius: 12.r,
              child: Center(child: Icon(icon, color: iconColor, size: 18.r)),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.tajawal(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    ),
    backgroundColor: backgroundColor, // استخدام اللون المحدد
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
  );

  // إضافة حركة الأنيميشن: عرض الـ SnackBar من اليمين
  final animationController = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: ScaffoldMessenger.of(context),
  );

  final slideAnimation = Tween<Offset>(
    begin: const Offset(1.0, 0.0), // تبدأ الرسالة من اليمين
    end: Offset.zero, // تنتهي عند الموضع الطبيعي
  ).animate(CurvedAnimation(parent: animationController, curve: Curves.easeInOut));

  // تحقق مما إذا كان الـ State لا يزال مركبًا (mounted)
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    animationController.forward();
  } else {
    print("State is unmounted, cannot show snackbar.");
  }
}
