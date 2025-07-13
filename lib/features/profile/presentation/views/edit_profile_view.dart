import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/core/widgets/calendar_picker_popup.dart';
import 'package:workspace/core/widgets/text_field_widget.dart';
import 'package:workspace/core/widgets/validator_widget.dart';
import 'package:workspace/features/profile/controllers/edit_profile_controller.dart';
import 'package:animate_do/animate_do.dart';
import 'package:workspace/utils/validators.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: FadeInDown(
          child: IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back, size: 24.r)),
        ),
        centerTitle: true,
        title: FadeInDown(
          child: Text(
            'الملف الشخصي',
            textAlign: TextAlign.right,
            style: GoogleFonts.tajawal(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: Color(0xFF212121),
            ),
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () => controller.submitEditProfile(),
        child: SlideInUp(
          duration: Duration(milliseconds: 500),
          child: Container(
            height: 83.h,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFF9FAFB), width: 1.w),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(0, 0, 0, 0.04),
                  offset: const Offset(0, -2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Center(
              child: Obx(
                () =>
                    controller.loading.isTrue
                        ? CircularProgressIndicator(color: AppColors.primary)
                        : Container(
                          height: 44.h,
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                          margin: EdgeInsets.symmetric(horizontal: 24.h),
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
                              Container(),
                            ],
                          ),
                        ),
              ),
            ),
          ),
        ),
      ),
      body: Form(
        key: controller.editProfileFormKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInUp(
                  delay: Duration(milliseconds: 300 + 1 * 100),
                  child: Text(
                    'لمحة عني',
                    style: GoogleFonts.tajawal(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF32B599),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                FadeInUp(
                  delay: Duration(milliseconds: 300 + 2 * 100),
                  child: TextFieldWidgets(
                    hint: '',
                    maxLines: 5,
                    radius: 8.r,
                    keyboardType: TextInputType.text,
                    controller: controller.aboutMeEditProfileTextEditingController,
                    validator: Validators.required,
                  ),
                ),
                SizedBox(height: 24),
                FadeInUp(
                  delay: Duration(milliseconds: 300 + 3 * 100),

                  child: Text(
                    'معلومات شخصية',
                    style: GoogleFonts.tajawal(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF32B599),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                FadeInUp(
                  delay: Duration(milliseconds: 300 + 4 * 100),

                  child: Text(
                    'الجنس',
                    style: GoogleFonts.tajawal(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF9E9E9E),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                FadeInUp(
                  delay: Duration(milliseconds: 300 + 5 * 100),

                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => controller.selectSex.value = 0,
                        child: Obx(
                          () => Container(
                            width: 24.w,
                            height: 24.h,
                            padding: EdgeInsets.all(2.r),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: controller.selectSex.value == 0 ? 4.w : 2.w,
                                color:
                                    controller.selectSex.value == 0
                                        ? Color(0xFF32B599)
                                        : Color(0xFFD6F0EB),
                              ),
                              shape: BoxShape.circle,
                            ),
                            child:
                                controller.selectSex.value == 0
                                    ? Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFF32B599),
                                        shape: BoxShape.circle,
                                      ),
                                    )
                                    : null,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'انثى',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.tajawal(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF32B599),
                        ),
                      ),
                      SizedBox(width: 44.w),
                      InkWell(
                        onTap: () => controller.selectSex.value = 1,
                        child: Obx(
                          () => Container(
                            width: 24.w,
                            height: 24.h,
                            padding: EdgeInsets.all(2.r),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: controller.selectSex.value == 1 ? 4.w : 2.w,
                                color:
                                    controller.selectSex.value == 1
                                        ? Color(0xFF32B599)
                                        : Color(0xFFD6F0EB),
                              ),
                              shape: BoxShape.circle,
                            ),
                            child:
                                controller.selectSex.value == 1
                                    ? Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFF32B599),
                                        shape: BoxShape.circle,
                                      ),
                                    )
                                    : null,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'ذكر',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.tajawal(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF32B599),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                FadeInUp(
                  delay: Duration(milliseconds: 300 + 6 * 100),

                  child: Text(
                    'تاريخ الميلاد',
                    style: GoogleFonts.tajawal(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF9E9E9E),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                FadeInUp(
                  delay: Duration(milliseconds: 300 + 7 * 100),

                  child: Obx(
                    () => TextFieldWidgets(
                      hint: controller.birthday.value.split(' ').first,
                      readOnly: true,
                      validator: (value) {
                        if (controller.birthday.value.isEmpty) {
                          return 'يرجى اختيار تاريخ الميلاد';
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        onPressed: () {


                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return CalendarPickerPopup(
                                enableYearPicker: true,

                                initialSelectedDate: DateTime.now(), // التاريخ الابتدائي
                                onDateSelected: (selectedDate) {
                                  print('التاريخ المختار: $selectedDate');
                                  controller.birthday.value = selectedDate.toString();
                                  // هنا تقدر تحدّث قيمة متغير أو TextField أو Controller
                                },
                              );
                            },
                          );
                        },
                        icon: SvgPicture.asset(AppSvg.calendarSvg, width: 24.w, height: 24.h),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                FadeInUp(
                  delay: Duration(milliseconds: 300 + 8 * 100),

                  child: Text(
                    'العمر',
                    style: GoogleFonts.tajawal(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF9E9E9E),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                FadeInUp(
                  delay: Duration(milliseconds: 300 + 9 * 100),
                  child: TextFieldWidgets(
                    hint: '',
                    keyboardType: TextInputType.number,
                    controller: controller.ageEditProfileTextEditingController,
                    validator: Validators.required,
                  ),
                ),
        if(controller.userType.value == 'student') Column(
          crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                   SizedBox(height: 24.h),
             FadeInUp(
                  delay: Duration(milliseconds: 300 + 10 * 100),

                  child: Text(
                    'التعليم',
                    style: GoogleFonts.tajawal(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF32B599),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                FadeInUp(
                  delay: Duration(milliseconds: 300 + 11 * 100),

                  child: Text(
                    'الجامعة',
                    style: GoogleFonts.tajawal(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF9E9E9E),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                FadeInUp(
                  delay: Duration(milliseconds: 300 + 12 * 100),

                  child: TextFieldWidgets(
                    hint: '',
                    keyboardType: TextInputType.text,
                    controller: controller.universityEditProfileTextEditingController,
                    validator: Validators.required,
                  ),
                ),
                SizedBox(height: 16.h),
                FadeInUp(
                  delay: Duration(milliseconds: 300 + 13 * 100),

                  child: Text(
                    'النخصص',
                    style: GoogleFonts.tajawal(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF9E9E9E),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                FadeInUp(
                  delay: Duration(milliseconds: 300 + 14 * 100),

                  child: TextFieldWidgets(
                    hint: '',
                    keyboardType: TextInputType.text,
                    controller: controller.majorEditProfileTextEditingController,
                    validator: Validators.required,
                  ),
                ),
                SizedBox(height: 16.h),
                FadeInUp(
                  delay: Duration(milliseconds: 300 + 15 * 100),

                  child: Text(
                    'الرقم الجامعي',
                    style: GoogleFonts.tajawal(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF9E9E9E),
                    ),
                  ),
                ),
                  SizedBox(height: 16.h),
                FadeInUp(
                  delay: Duration(milliseconds: 300 + 16 * 100),

                  child: TextFieldWidgets(
                    hint: '',
                    keyboardType: TextInputType.number,
                    controller: controller.universityIdEditProfileTextEditingController,
                    validator: Validators.required,
                  ),
                ),
              ],
             ),

                SizedBox(height: 24),
                FadeInUp(
                  delay: Duration(milliseconds: 300 + 17 * 100),

                  child: Text(
                    'المستندات المطلوبة ',
                    style: GoogleFonts.tajawal(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF32B599),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                FadeInUp(
                  delay: Duration(milliseconds: 300 + 18 * 100),

                  child: InkWell(
                    onTap: () => controller.pickPdfFile(),
                    child: ValidateWidget(
                      validator: (value) {
                        if (controller.filepath.isNotEmpty) {
                          return null;
                        }
                        return 'حقل مطلوب';
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 29.h, horizontal: 36.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(color: Color(0xFFF5F5F5), width: 1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_downward_rounded,
                              size: 24.r,
                              color: Color(0xFF32B599),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'ارفق المستندات المطلوبة',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.tajawal(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF32B599),
                                height: 1.4,
                                letterSpacing: 0.2,
                              ),
                            ),
                            Container(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),

                Obx(
                  () => FadeInUp(
                    delay: Duration(milliseconds: 300 + 19 * 100),

                    child: Row(
                      children: List.generate(
                        controller.filepath.length,
                        (index) => Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 8.w),
                              child: ZoomIn(
                                duration: Duration(milliseconds: 300),
                                child: SvgPicture.asset(AppSvg.pdfSvg),
                              ),
                            ),
                            Positioned(
                              top: -1,
                              right: -1,
                              child: InkWell(
                                onTap: () => controller.filepath.removeAt(index),
                                child: CircleAvatar(
                                  radius: 10.r,
                                  backgroundColor: Color(0xFFF5F5F5),
                                  child: Center(
                                    child: Icon(Icons.close, color: Color(0xFFBDBDBD), size: 16.r),
                                  ),
                                ),
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
      ),
    );
  }
}
