import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/core/theme/text_styles.dart';
import 'package:workspace/core/widgets/text_field_widget.dart';
import 'package:workspace/features/profile/controllers/change_password_controller.dart';
import 'package:animate_do/animate_do.dart';
import 'package:workspace/utils/validators.dart';

class ChangePasswordView extends GetView<ChangepasswordPageController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back, size: 24.r)),
        centerTitle: true,
        title: Text(
          'كلمة المرور',
          textAlign: TextAlign.right,
          style: GoogleFonts.tajawal(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Color(0xFF212121),
          ),
        ),
      ),
      body: Form(
        key: controller.changePasswordFormKey,
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _animatedPasswordField(
                1,
                'كلمة المرور الحالية',
                controller.obscureTextold,
                [AutofillHints.password],
                TextInputAction.next,
                controller.oldPasswordChangePasswordTextEditingController,
                (value) => Validators.minLength(value, 6, fieldName: 'كلمة المرور'),
              ),

              _animatedPasswordField(
                2,
                'كلمة المرور الجديدة',
                controller.obscureTextnew,
                [AutofillHints.password],
                TextInputAction.next,
                controller.newPasswordChangePasswordTextEditingController,
                (value) => Validators.minLength(value, 6, fieldName: 'كلمة المرور'),
              ),
              _animatedPasswordField(
                3,
                'تاكيد كلمة المرور',
                controller.obscureTextcon,
                [AutofillHints.password],
                TextInputAction.next,
                controller.conPasswordChangePasswordTextEditingController,
                (value) => Validators.match(
                  value,
                  controller.newPasswordChangePasswordTextEditingController.text,
                  fieldName: 'تأكيد كلمة المرور',
                ),
              ),

              SizedBox(height: 22.h),
              Obx(
                ()=> controller.loading.isTrue ? Center(
                                      child: CircularProgressIndicator(color: AppColors.primary),
                                    ) : ZoomIn(
                  duration: Duration(milliseconds: 500),
                  child: InkWell(
                    onTap: () => controller.submitChangePassword(),
                    child: Center(
                      child: Container(
                        height: 44.h,
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF32B599),
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'تغيير كلمة المرور',
                              style: GoogleFonts.tajawal(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
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
    RxBool obscureText,
    Iterable<String>? autofillHints,
    TextInputAction textInputAction,
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
              obscureText: obscureText.value,
              autofillHints: autofillHints,
              textInputAction: textInputAction,
              validator: validator,
              suffixIcon: IconButton(
                icon:
                    SvgPicture.asset(
                      obscureText.value
                        ?
                          AppSvg.eyeslashSvg : AppSvg.eyeSvg,
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
        SizedBox(height: 12.h),
      ],
    );
  }
}
