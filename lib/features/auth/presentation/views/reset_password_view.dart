import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/core/theme/text_styles.dart';
import 'package:workspace/features/auth/controllers/reset_password_controller.dart';
import 'package:workspace/features/auth/presentation/widgets/button_login_widget.dart';
import 'package:workspace/features/auth/presentation/widgets/remember_password_login_btn_widgt.dart';
import 'package:workspace/core/widgets/text_field_widget.dart';
import 'package:workspace/utils/routing.dart';
import 'package:workspace/utils/validators.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Form(
      key: controller.formResetPasswordKey,
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
                    FadeInRight(
                      child: Center(
                  child: Image.asset(AppImage.logoImage),
                ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              FadeIn(
                child: Container(
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
              ),
              Expanded(
                child: FadeInUp(
                  duration: const Duration(milliseconds: 600),
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
                                height: 60.h,
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
                                child: Center(
                                  child: SvgPicture.asset(AppSvg.vectorSvg),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 24.sp),
                          FadeInDown(
                            child: Center(
                              child: Text(
                                'استعادة كلمة المرور'.tr,
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
                                'ادخل البريد الالكتروني الخاص بك وسنقوم بارسال رمز التحقق لاعادة تعيين كلمة المرور الخاصة بك'.tr,
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
                          FadeIn(
                            child: Text(
                              'email'.tr,
                              style: AppTextStyles.body,
                            ),
                          ),
                          SizedBox(height: 10.sp),
                          FadeInUp(
                            delay: const Duration(milliseconds: 300),
                            child: TextFieldWidgets(
                              controller: controller.emailResetPasswordTextEditingController,
                              keyboardType: TextInputType.emailAddress,
                              autofillHints: [AutofillHints.email],
                              textInputAction: TextInputAction.done,
                              hint: 'AreistoSpace@gmail.com',
                              validator: Validators.email,
                              icon: IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  AppSvg.smsSvg,
                                  width: 24.w,
                                  height: 24.h,
                                  color: const Color(0xFF757575),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 24.sp),
                          Obx(
                            ()=> controller.loading.isTrue ?
                            Center(
                                      child: CircularProgressIndicator(color: AppColors.primary),
                                    )
                            : BounceInUp(
                              delay: const Duration(milliseconds: 400),
                              child: ButtonLoginWidget(
                                text: 'ارسل رمز التحقق'.tr,
                                onTap: () =>controller.submitResetPassword(),
                              ),
                            ),
                          ),
                          const Spacer(),
                          FadeInUp(
                            delay: const Duration(milliseconds: 500),
                            child: RememberPasswordAndLoginButtonWidgt(),
                          ),
                        ],
                      ),
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
