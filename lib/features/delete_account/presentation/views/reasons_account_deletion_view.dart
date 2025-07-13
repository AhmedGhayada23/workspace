import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/features/auth/presentation/widgets/button_login_widget.dart';
import 'package:workspace/features/delete_account/controllers/reasons_account_deletion_controller.dart';
import 'package:workspace/features/profile/presentation/widgets/edit_confirmation_dialog_widget.dart';
import 'package:workspace/utils/routing.dart';
import 'package:animate_do/animate_do.dart'; // إضافة animate_do

class ReasonsAccountDeletionView extends GetView<ReasonsAccountDeletionController> {
  const ReasonsAccountDeletionView({super.key});

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
        title: FadeInDown(
          child: Text(
            'سبب حذف الحساب',
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
      body: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              delay: Duration(milliseconds: 100),
              child: Text(
                'لماذا تريد حذف حسابك ؟',
                style: GoogleFonts.tajawal(
                  color: Color(0xFF212121),
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
              child: ListView.separated(
                   physics: NeverScrollableScrollPhysics(),
                   shrinkWrap: true,
                   itemBuilder: (context, index){
                      String reason = controller.reasons[index];

                     return GestureDetector(
                       onTap: () => controller.toggleReason(reason),
                       child:Obx(
                         ()=> Container(
                           height: 48.h,
                           padding: EdgeInsets.symmetric(horizontal: 16.w),
                           decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(50.r),
                             border: Border.all(
                               color: Color(0xFFF5F5F5),
                               width: 1.w,
                             ),
                           ),
                           child: Row(
                             children: [
                               Text(
                                 reason,
                                 style: GoogleFonts.tajawal(
                                   color: Color(0xFF212121),
                                   fontSize: 12.sp,
                                   fontWeight: FontWeight.w500,
                                 ),
                               ),
                               Spacer(),
                               Container(
                                 width: 24.w,
                                 height: 24.h,
                                 decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                   border: Border.all(
                                     width: 2.w,
                                     color:  controller.selectedReasons.contains(reason) ? Color(0xFF32B599) : Color(0xFFD6F0EB),
                                   ),
                                   color:  controller.selectedReasons.contains(reason) ? Color(0xFF32B599) : Colors.transparent,
                                 ),
                                 child:  controller.selectedReasons.contains(reason)
                                     ? Icon(Icons.check, color: Colors.white, size: 16.r)
                                     : null,
                               ),
                             ],
                           ),
                         ),
                       ),
                     );
                   },
                   separatorBuilder: (context, index) => SizedBox(height: 8.h),
                   itemCount: controller.reasons.length,
                 ),
            ),
            SizedBox(height: 32.h),
            FadeInUp(
              delay: Duration(milliseconds: 300),
              child: ButtonLoginWidget(
                text: 'حذف الحساب'.tr,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => EditConfirmationDialog(
                      title: 'هل انت متأكد ؟',
                      subTitle: 'هل انت متأكد من حذف الحساب ؟',
                      textConfirm: 'حذف الحساب',
                      textConfirmColor: Color(0xFFF75555),
                      textCanselColor: Color(0xFF000000),
                      onConfirm: () {
                        Get.offAllNamed(AppRouting.signInView);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
