import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/animated/text_field_animated.dart';
import 'package:workspace/core/config/storage/local_storage.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/core/theme/text_styles.dart';
import 'package:workspace/features/auth/controllers/sign_in_controller.dart';
import 'package:workspace/features/auth/presentation/widgets/button_login_widget.dart';
import 'package:workspace/features/auth/presentation/widgets/button_with_google_widget.dart';
import 'package:workspace/features/auth/presentation/widgets/divider_or_widget.dart';
import 'package:workspace/features/auth/presentation/widgets/remember_me_and_Forgot_password_widget.dart';
import 'package:workspace/features/auth/presentation/widgets/sign_up_prompt_widget.dart';
import 'package:workspace/core/widgets/text_field_widget.dart';
import 'package:workspace/utils/routing.dart';
import 'package:animate_do/animate_do.dart';
import 'package:workspace/utils/validators.dart';

class SiginInView extends GetView<SignInController> {
  const SiginInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Form(
        key: controller.signInFormKey,
        child: Container(
          color: AppColors.primary,
          child: Column(
            children: [
              SizedBox(height: 45.h),
              FadeInDown(
                duration: Duration(milliseconds: 600),
                child: Center(child: Image.asset(AppImage.logoImage)),
              ),
              SizedBox(height: 56.h),
              FadeInDown(
                duration: Duration(milliseconds: 600),
                delay: Duration(milliseconds: 200),
                child: SignUpPromptWidget(
                  title: 'dont_Have_An_account'.tr,
                  btuTitle: 'sign_up_now'.tr,
                  onTap: () => Get.offNamed(AppRouting.signUpView),
                ),
              ),
              SizedBox(height: 24.h),
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
                    padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 32.h),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutofillGroup(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...animatedField(
                                  1,
                                  'email'.tr,
                                  'AreistoSpace@gmail.com',
                                  AppSvg.smsSvg,
                                  TextInputType.emailAddress,
                                  [AutofillHints.email],
                                  TextInputAction.next,
                                  null,
                                  controller.emailSignInTextEditingController,
                                  Validators.email,
                                ),

                                _animatedPasswordField(
                                  2,
                                  'password'.tr,
                                  [AutofillHints.password],
                                  TextInputAction.done,
                                  controller.passwordSignInTextEditingController,
                                  (value) =>
                                      Validators.minLength(value, 6, fieldName: 'كلمة المرور'),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 16.h),
                          FadeInUp(
                            duration: Duration(milliseconds: 600),
                            delay: Duration(milliseconds: 700),
                            child: Obx(
                              () => RememberMeAndForgotPasswordWidget(
                                isChecked: controller.isChecked.value,
                                onChanged: (value) {
                                  controller.isChecked.value = value!;
                                  controller.loginRemembar();
                                },
                                onForgotPassword: () => Get.offNamed(AppRouting.resetPasswordView),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),

                          Obx(
                            () =>
                                controller.loading.isTrue
                                    ? Center(
                                      child: CircularProgressIndicator(color: AppColors.primary),
                                    )
                                    : FadeInUp(
                                      duration: Duration(milliseconds: 600),
                                      delay: Duration(milliseconds: 800),
                                      child: ButtonLoginWidget(
                                        text: 'login'.tr,
                                        onTap: () => controller.submitSignIn(),
                                      ),
                                    ),
                          ),
                          SizedBox(height: 16.h),
                          FadeInUp(
                            duration: Duration(milliseconds: 600),
                            delay: Duration(milliseconds: 900),
                            child: OrDividerWidget(),
                          ),
                          SizedBox(height: 16.h),
                          FadeInUp(
                            duration: Duration(milliseconds: 600),
                            delay: Duration(milliseconds: 1000),
                            child: ButtonWithGoogleWidget(
                              onTap: () => controller.signInWithGoogle(),
                            ),
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
    TextInputAction? textInputAction,
    TextEditingController? textEditingController,
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
              autofillHints: autofillHints,
              obscureText: controller.obscureText.value,
              textInputAction: textInputAction,
              validator: validator,
              suffixIcon: IconButton(
                icon:
                     SvgPicture.asset(
                       controller.obscureText.value
                        ?   AppSvg.eyeslashSvg : AppSvg.eyeSvg,
                          color: Color(0xFF757575),
                          width: 24.w,
                          height: 24.h,
                        ),

                onPressed: () {
                  controller.obscureText.value = !controller.obscureText.value;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
