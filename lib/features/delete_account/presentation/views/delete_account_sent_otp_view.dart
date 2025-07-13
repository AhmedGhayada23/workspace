import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/features/auth/presentation/widgets/button_login_widget.dart';
import 'package:workspace/core/widgets/text_field_widget.dart';
import 'package:workspace/features/delete_account/controllers/delete_account_sent_otp_controller.dart';
import 'package:workspace/utils/routing.dart';
import 'package:animate_do/animate_do.dart';
import 'package:workspace/utils/validators.dart'; // أضفنا المكتبة هنا

class DeleteAccountSentOtpView extends GetView<DeleteAccountSentOtpController> {
  const DeleteAccountSentOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, size: 24.r),
        ),
        centerTitle: true,
        title: FadeInDown( // <-- Animation على العنوان
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
        key: controller.deleteAccountFormKey,
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                delay: Duration(milliseconds: 100),
                child: Text(
                  'لحذف الحساب ادخل بريدك الالكتروني المربوط فالحساب',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.tajawal(
                    color: Color(0xFF32B599),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    height: 1.0,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              FadeInRight(
                delay: Duration(milliseconds: 200),
                child: Text(
                  'البريد الالكتروني',
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
                delay: Duration(milliseconds: 300),
                child: TextFieldWidgets(hint: 'areistospace@gmail.com',autofillHints: [AutofillHints.email],textInputAction: TextInputAction.done,controller: controller.emaildeleteAccountTextEditingController,validator: Validators.email,),
              ),
              SizedBox(height: 32.h),
              Obx(
                () => controller.loading.isTrue ?
                Center(
                                      child: CircularProgressIndicator(color: AppColors.primary),
                                    ) :
                 FadeInUp(
                  delay: Duration(milliseconds: 400),
                  child: ButtonLoginWidget(
                    text: 'تحقق'.tr,
                    onTap: () => controller.submitDeleteAccount(),
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
