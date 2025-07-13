import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:animate_do/animate_do.dart';

import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/core/theme/text_styles.dart';
import 'package:workspace/features/auth/controllers/otp_controller.dart';
import 'package:workspace/features/auth/presentation/widgets/button_login_widget.dart';
import 'package:workspace/features/auth/presentation/widgets/remember_password_login_btn_widgt.dart';
import 'package:workspace/utils/routing.dart';

class OTPView extends GetView<OTPController> {
  const OTPView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Form(
        key: controller.otpFormKey,
        child: Container(
          color: AppColors.primary,
          child: Column(
            children: [
              SizedBox(height: 45.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FadeInLeft(
                      child: IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(Icons.arrow_back_rounded, color: AppColors.white, size: 24.r),
                      ),
                    ),
                    FadeInRight(child: Center(child: Image.asset(AppImage.logoImage))),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              Container(
                height: 16.h,
                margin: EdgeInsets.symmetric(horizontal: 35.w),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(20, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 32.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: ZoomIn(
                            duration: const Duration(milliseconds: 600),
                            child: Container(
                              height: 55.h,
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
                              child: Center(child: SvgPicture.asset(AppSvg.sentCodeSvg)),
                            ),
                          ),
                        ),
                        SizedBox(height: 24.sp),
                        FadeInDown(
                          child: Center(
                            child: Text(
                              'sent_code'.tr.tr,
                              style: GoogleFonts.tajawal(
                                color: AppColors.primary,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 4.sp),
                        FadeInDown(
                          delay: const Duration(milliseconds: 200),
                          child: Center(
                            child: Text(
                              'code_sent_email'.tr,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.tajawal(
                                color: const Color(0xFF616161),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 32.sp),
                        FadeIn(child: Text('verification_code'.tr, style: AppTextStyles.body)),
                        SizedBox(height: 12.h),
                        SlideInUp(
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Pinput(
                              length: 5,
                              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                              showCursor: true,
                              separatorBuilder: (index) => SizedBox(width: 8.w),
                              hapticFeedbackType: HapticFeedbackType.lightImpact,
                              errorTextStyle: GoogleFonts.tajawal(
                                color: const Color.fromARGB(255, 189, 0, 0),
                              ),

                              onCompleted: (pin) {
                                debugPrint('onCompleted: $pin');
                                controller.code.value = pin;
                                controller.submitOtpCode();
                              },
                              onChanged: (value) {
                                debugPrint('onChanged: $value');
                              },
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'الرمز مطلوب';
                                }
                                if (value.length != 5) {
                                  return 'الرمز يجب أن يكون 5 أرقام';
                                }
                                return null;
                              },
                              cursor: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 9.h),
                                    width: 22.w,
                                    height: 1.h,
                                    color: AppColors.primary,
                                  ),
                                ],
                              ),
                              defaultPinTheme: PinTheme(
                                width: 78.w,
                                height: 48.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.r),
                                  border: Border.all(color: const Color(0xFFECF1F6)),
                                ),
                              ),
                              disabledPinTheme: PinTheme(
                                width: 78.w,
                                height: 48.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.r),
                                  border: Border.all(color: const Color(0xFFECF1F6)),
                                ),
                              ),
                              focusedPinTheme: PinTheme(
                                width: 78.w,
                                height: 48.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.r),
                                  border: Border.all(color: AppColors.primary),
                                ),
                              ),
                              submittedPinTheme: PinTheme(
                                width: 78.w,
                                height: 48.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.r),
                                  border: Border.all(color: AppColors.primary),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        FadeIn(
                          delay: const Duration(milliseconds: 300),
                          child: Obx(() {
                            return controller.canResend.value
                                ? InkWell(
                                  onTap: () => controller.resendCode(),
                                  child: Center(
                                    child: Text(
                                      'resend_code'.tr,
                                      style: GoogleFonts.tajawal(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                )
                                : Center(
                                  child: Text(
                                    controller.formattedTime,
                                    style: GoogleFonts.tajawal(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                );
                          }),
                        ),
                        SizedBox(height: 24.sp),
                        Obx(
                          () =>
                              controller.loading.isTrue
                                  ? Center(
                                    child: CircularProgressIndicator(color: AppColors.primary),
                                  )
                                  : BounceInUp(
                                    child: ButtonLoginWidget(
                                      text: 'check'.tr,
                                      onTap: () => controller.submitOtpCode(),
                                    ),
                                  ),
                        ),
                        const Spacer(),
                        FadeInUp(child: RememberPasswordAndLoginButtonWidgt()),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
