import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/animated/animated_dropdown.dart';
import 'package:workspace/core/animated/text_field_animated.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/core/widgets/text_field_widget.dart';
import 'package:workspace/features/bottom_navigation_bar/controllers/btn_nav_controller.dart';
import 'package:workspace/features/profile/controllers/setting_profile_controller.dart';
import 'package:animate_do/animate_do.dart';
import 'package:workspace/utils/validators.dart';

class SettingProfileView extends GetView<SettingProfileController> {
  const SettingProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back, size: 24.r)),
        centerTitle: true,
        title: Text(
          'حسابي',
          textAlign: TextAlign.right,
          style: GoogleFonts.tajawal(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Color(0xFF212121),
          ),
        ),
      ),
      body: Form(
        key: controller.settingProfileFormKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FadeIn(
                  duration: Duration(milliseconds: 500),
                  child: InkWell(
                    onTap: () => controller.showTakePhoto(context),
                    child: Center(
                      child: Obx(
                        ()=> Container(
                          width: 78.w,
                          height: 77.h,
                          padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 26),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                const Color.fromRGBO(0, 0, 0, 0.2),
                                const Color.fromRGBO(0, 0, 0, 0.2),
                              ],
                            ),
                            image: controller.imageFile.value != null ? DecorationImage(image:  FileImage(controller.imageFile.value!),fit: BoxFit.cover) : Get.parameters['image'] != '' ? DecorationImage(image:  NetworkImage(Get.parameters['image'].toString()),) : null,
                          ),
                          child: SvgPicture.asset(AppSvg.cameraSvg,width: 24.w,height: 24.h,color: AppColors.white,),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                AutofillGroup(child:

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
           ...animatedField(1,  'الاسم كامل', '', null,TextInputType.text,[AutofillHints.name],TextInputAction.go,null,controller.fullNameSettingProfileTextEditingController,(value) => Validators.required(value, fieldName: 'الاسم')),

                ...animatedDropdown(2,
                controller.typeTitle.value,
                controller.userTypes.keys.toList(),
              (value) => Validators.required(value),
                                  (value) {
                                    FocusScope.of(context).requestFocus(controller.nextFieldFocus);
                                    controller.types.value =
                                        controller.userTypes[value]!; // تخزين القيمة الإنجليزية
                                    log('user type :: ${controller.userTypes[value]!}');
                                  },),
              ...animatedField(3,  'رقم الهاتف', '', null, TextInputType.phone,[AutofillHints.telephoneNumber],TextInputAction.next,controller.nextFieldFocus,controller.phoneSettingProfileTextEditingController,Validators.phone),
              ...animatedField(4,   'البريد الالكتروني', '', null, TextInputType.emailAddress,[AutofillHints.email],TextInputAction.done,null,controller.emailSettingProfileTextEditingController,Validators.email),

                  ],
                )
                ),







                SizedBox(height: 22.h),
                Obx(
                  ()=> controller.loading.isTrue ?
                  Center(
                                      child: CircularProgressIndicator(color: AppColors.primary),
                                    ) :
                   ZoomIn(
                    duration: Duration(milliseconds: 500),
                    child: InkWell(
                      onTap: () => controller.submitSettingProfile(),
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
                              SvgPicture.asset(AppSvg.editSvg, color: AppColors.white),
                              SizedBox(width: 8.w),
                              Text(
                                'حفظ التعديلات',
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
      ),
    );
  }
}
