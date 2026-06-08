import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:workspace/core/animated/animated_dropdown.dart';
import 'package:workspace/core/animated/text_field_animated.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/core/theme/text_styles.dart';
import 'package:workspace/features/auth/controllers/sign_up_controller.dart';
import 'package:workspace/features/auth/presentation/widgets/button_login_widget.dart';
import 'package:workspace/features/auth/presentation/widgets/button_with_google_widget.dart';
import 'package:workspace/features/auth/presentation/widgets/divider_or_widget.dart';
import 'package:workspace/features/auth/presentation/widgets/sign_up_prompt_widget.dart';
import 'package:workspace/core/widgets/text_field_widget.dart';
import 'package:workspace/utils/routing.dart';
import 'package:animate_do/animate_do.dart';
import 'package:workspace/utils/validators.dart';

class SiginUpView extends GetView<SignUpController> {
  const SiginUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Form(
        key: controller.registerFormKey,
        child: Container(
          color: AppColors.primary,
          child: Column(
            children: [
              SizedBox(height: 32.h),
              FadeInDown(
                duration: Duration(milliseconds: 600),
                child: Center(
                    child: Center(child: Image.asset(AppImage.logoImage))),
              ),
              SizedBox(height: 24.h),
              FadeInDown(
                delay: Duration(milliseconds: 200),
                duration: Duration(milliseconds: 600),
                child: SignUpPromptWidget(
                  title: 'do_you_have_an_account'.tr,
                  btuTitle: 'login'.tr,
                  onTap: () => Get.offNamed(AppRouting.signInView),
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                height: 16.h,
                margin: EdgeInsets.symmetric(horizontal: 35.w),
                decoration: BoxDecoration(
                  color: Color.fromARGB(20, 255, 255, 255),
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.h, vertical: 32.h),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutofillGroup(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...animatedField(
                                  0,
                                  'full_name'.tr,
                                  'Areisto Space',
                                  AppSvg.profileSvg,
                                  TextInputType.text,
                                  [AutofillHints.name],
                                  TextInputAction.go,
                                  null,
                                  controller
                                      .fullNameRegisterTextEditingController,
                                  (value) => Validators.required(value,
                                      fieldName: 'الاسم'),
                                ),
                                ...animatedDropdown(
                                  1,
                                  null,
                                  controller.userTypes.keys
                                      .toList(), // عرض القيم العربية
                                  (value) => Validators.required(value),
                                  (value) {
                                    FocusScope.of(context).requestFocus(
                                        controller.nextFieldFocus);
                                    controller.types.value =
                                        controller.userTypes[
                                            value]!; // تخزين القيمة الإنجليزية
                                    log('user type :: ${controller.userTypes[value]!}');
                                  },
                                ),
                                ...animatedField(
                                  2,
                                  'phone_number'.tr,
                                  '059 7146 852',
                                  AppSvg.mdiPhoneOutlineSvg,
                                  TextInputType.phone,
                                  [AutofillHints.telephoneNumber],
                                  TextInputAction.next,
                                  controller.nextFieldFocus,
                                  controller.phoneRegisterTextEditingController,
                                  Validators.phone,
                                ),
                                ...animatedField(
                                  3,
                                  'email'.tr,
                                  'AreistoSpace@gmail.com',
                                  AppSvg.smsSvg,
                                  TextInputType.emailAddress,
                                  [AutofillHints.email],
                                  TextInputAction.next,
                                  null,
                                  controller.emailRegisterTextEditingController,
                                  Validators.email,
                                ),
                                _animatedPasswordField(
                                  4,
                                  'password'.tr,
                                  [AutofillHints.password],
                                  TextInputAction.next,
                                  controller
                                      .passwordRegisterTextEditingController,
                                  controller.obscureTextpassword,
                                  (value) => Validators.minLength(value, 6,
                                      fieldName: 'كلمة المرور'),
                                ),
                                _animatedPasswordField(
                                  5,
                                  'confirm_password'.tr,
                                  null,
                                  TextInputAction.done,
                                  controller
                                      .confirmRegisterTextEditingController,
                                  controller.obscureTextconfirmpassword,
                                  (value) => Validators.match(
                                    value,
                                    controller
                                        .passwordRegisterTextEditingController
                                        .text,
                                    fieldName: 'تأكيد كلمة المرور',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Obx(
                            () => controller.loading.isTrue
                                ? Center(
                                    child: CircularProgressIndicator(
                                        color: AppColors.primary),
                                  )
                                : FadeInUp(
                                    delay: Duration(milliseconds: 600),
                                    duration: Duration(milliseconds: 600),
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 12.h),
                                      child: ButtonLoginWidget(
                                        onTap: () =>
                                            controller.submitRegister(),
                                        text: 'register_new_user'.tr,
                                      ),
                                    ),
                                  ),
                          ),
                          FadeInUp(
                            delay: Duration(milliseconds: 700),
                            duration: Duration(milliseconds: 600),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: OrDividerWidget(),
                            ),
                          ),
                          FadeInUp(
                            delay: Duration(milliseconds: 800),
                            duration: Duration(milliseconds: 600),
                            child: ButtonWithGoogleWidget(
                                onTap: () => controller.signInWithGoogle()),
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

  Widget _animatedPasswordField(
    int index,
    String label,
    Iterable<String>? autofillHints,
    TextInputAction textInputAction,
    TextEditingController? textEditingController,
    RxBool obscureText,
    String? Function(String?)? validator,
  ) {
    final delay = Duration(milliseconds: 300 + index * 100);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInUp(
          delay: delay,
          duration: Duration(milliseconds: 600),
          child: Text(label, style: AppTextStyles.body),
        ),
        SizedBox(height: 10.sp),
        FadeInUp(
          delay: delay + Duration(milliseconds: 100),
          duration: Duration(milliseconds: 600),
          child: Obx(
            () => TextFieldWidgets(
              controller: textEditingController,
              hint: '***********',
              obscureText: obscureText.value,
              autofillHints: autofillHints,
              textInputAction: textInputAction,
              validator: validator,
              suffixIcon: IconButton(
                icon: SvgPicture.asset(
                  obscureText.value ? AppSvg.eyeslashSvg : AppSvg.eyeSvg,
                  color: Color(0xFF757575),
                  width: 24.w,
                  height: 24.h,
                ),
                onPressed: () {
                  obscureText.value = !obscureText.value;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
