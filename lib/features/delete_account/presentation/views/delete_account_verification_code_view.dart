import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/features/auth/presentation/widgets/button_login_widget.dart';
import 'package:workspace/core/widgets/text_field_widget.dart';
import 'package:workspace/features/delete_account/controllers/delete_account_verification_code_controller.dart';
import 'package:workspace/features/profile/presentation/widgets/edit_confirmation_dialog_widget.dart';
import 'package:workspace/utils/routing.dart';
import 'package:animate_do/animate_do.dart';
import 'package:workspace/utils/validators.dart'; // إضافة animate_do

class DeleteAccountVerificationCodeView extends GetView<DeleteAccountVerificationCodeController> {
  const DeleteAccountVerificationCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.0,
        leading: IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back, size: 24.r)),
        centerTitle: true,
        title: FadeInDown(
          child: Text(
            'حذف الحساب',
            style: GoogleFonts.tajawal(
              color: Color(0xFF212121),
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              height: 1.0,
            ),
          ),
        ),
      ),
      body: Form(
        key: controller.verificationdeleteAccountFormKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                delay: Duration(milliseconds: 100),
                child: Text(
                  'ادخل رمز التحقق',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.tajawal(
                    color: Color(0xFF32B599),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    height: 1.0,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              FadeInDown(
                delay: Duration(milliseconds: 200),
                child: Text(
                  'المرسل على الايميل areistospace@gmail.com',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.tajawal(
                    color: Color(0xFF9E9E9E),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    height: 1.0,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              FadeInRight(
                delay: Duration(milliseconds: 300),
                child: Text(
                  'رمز التحقق',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.tajawal(
                    color: Color(0xFF212121),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    height: 1.0,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              FadeInRight(
                delay: Duration(milliseconds: 400),
                child: TextFieldWidgets(
                  hint: '5555',
                  autofillHints: [],
                  textInputAction: TextInputAction.done,
                  controller: controller.otpVerificationdeleteAccountTextEditingController,
                  validator: (value) => Validators.minLength(value, 4, fieldName: 'رمز التحقق'),
                ),
              ),
              SizedBox(height: 32.h),
              Obx(
                ()=> controller.loading.isTrue ?
                Center(
                                      child: CircularProgressIndicator(color: AppColors.primary),
                                    ) :
                 FadeInUp(
                  delay: Duration(milliseconds: 500),
                  child: ButtonLoginWidget(
                    text: 'حذف الحساب'.tr,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => EditConfirmationDialog(
                              title: 'هل انت متأكد ؟',
                              subTitle: 'هل انت متأكد من حذف الحساب ؟',
                              textConfirm: 'حذف الحساب',
                              textConfirmColor: Color(0xFFF75555),
                              textCanselColor: Color(0xFF000000),
                              onConfirm: () {
                                controller.submitVerificationDeleteAccount();
                              },
                            ),
                      );
                    },
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
