import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/localization/app_tr.dart';
import 'package:workspace/core/navigation/app_navigator.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/features/auth/presentation/widgets/auth_logo_header.dart';
import 'package:workspace/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:workspace/features/auth/presentation/widgets/button_login_widget.dart';

class CongratulationsView extends StatelessWidget {
  const CongratulationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = sl<AppNavigator>();
    return AuthScaffold(
      header: AuthLogoHeader(onBack: nav.back),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24.sp),
          Center(child: SvgPicture.asset(AppSvg.congratulationsSvg)),
          SizedBox(height: 16.sp),
          Center(
            child: Text(
              'تهانينا!'.tr,
              style: GoogleFonts.tajawal(
                color: AppColors.black,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 4.sp),
          Center(
            child: Text(
              'لقد تم تغيير كلمة مرور حسابك بنجاح , يمكنك الان العودة وتسجيل الدخول من جديد !'.tr,
              textAlign: TextAlign.center,
              style: GoogleFonts.tajawal(
                color: const Color(0xFF616161),
                fontSize: 12.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          SizedBox(height: 32.sp),
          ButtonLoginWidget(text: 'login'.tr, onTap: nav.offAllToSignIn),
        ],
      ),
    );
  }
}
