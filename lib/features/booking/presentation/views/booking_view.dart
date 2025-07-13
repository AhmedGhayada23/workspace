import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/core/widgets/calendar_picker_popup.dart';
import 'package:workspace/core/widgets/time_picker_popup.dart';
import 'package:workspace/core/widgets/text_field_widget.dart';
import 'package:workspace/features/booking/controllers/booking_controller.dart';
import 'package:workspace/features/details_space/data/model/details_space_model.dart';
import 'package:workspace/utils/routing.dart';
import 'package:workspace/utils/validators.dart';

class BookingView extends GetView<BookingController> {
  const BookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, size: 24.r, color: Color(0xFF212121)),
        ),
        centerTitle: true,
        title: FadeInDown(
          child: Text(
            'طلب حجز',
            style: GoogleFonts.tajawal(
              color: Color(0xFF212121),
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () => controller.submitBooking(),
        child: BounceInUp(
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
              child: Container(
                height: 44.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                margin: EdgeInsets.symmetric(horizontal: 24.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF32B599),
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Center(
                  child: Text(
                    'ارسل الحجز',
                    style: GoogleFonts.tajawal(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.bookingFormKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInUp(
                  duration: Duration(milliseconds: 300),
                  child: Text(
                    'نوع الاشتراك',
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                FadeInUp(
                  duration: Duration(milliseconds: 400),
                  child: CustomDropdown(
                    hintText: 'اختر الاشتراك',
                    items:
                        controller.subscriptions
                            .map((e) => '${e.typeTitle} - ${e.price!.split('.0').first} شيكل')
                            .toList(),

                    // تعديل حسب اسم الحقل
                    onChanged: (value) {
                      // الحصول على الاشتراك الذي تم اختياره
                      final selectedSubscription = controller.subscriptions.firstWhere(
                        (e) => '${e.typeTitle} - ${e.price!.split('.0').first} شيكل' == value,
                      );

                      controller.subscriptionId.value = selectedSubscription.id!;
                    },
                    validator: (p0) => Validators.required(p0.toString()),
                    decoration: CustomDropdownDecoration(
                      hintStyle: GoogleFonts.tajawal(fontSize: 16.sp, color: Color(0xFF9E9E9E)),
                      headerStyle: GoogleFonts.tajawal(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      listItemStyle: GoogleFonts.tajawal(fontSize: 14.sp),
                      closedBorderRadius: BorderRadius.circular(50.r),
                      expandedBorderRadius: BorderRadius.circular(8.r),
                      closedBorder: Border.all(color: Color(0xFFF5F5F5), width: 1.r),
                      expandedBorder: Border.all(color: Color(0xFFF5F5F5), width: 1.r),
                      errorStyle: GoogleFonts.tajawal(),
                      closedErrorBorder: Border.all(color: Color(0xFFF5F5F5), width: 1.r),
                      closedErrorBorderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                FadeInUp(
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    'عدد المقاعد',
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                FadeInUp(
                  duration: Duration(milliseconds: 600),
                  child: TextFieldWidgets(
                    controller: controller.seatsCountTextEditingController,
                    hint: '',
                    keyboardType: TextInputType.number,
                    validator: Validators.positiveInteger,
                  ),
                ),
                SizedBox(height: 16.h),
                FadeInUp(
                  duration: Duration(milliseconds: 700),
                  child: Text(
                    'تاريخ البدء',
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                FadeInUp(
                  duration: Duration(milliseconds: 800),
                  child: Obx(
                    () => TextFieldWidgets(
                      hint: controller.startDate.value.split(' ').first,
                      readOnly: true,
                    validator: (value) {
  if (controller.startDate.value.isEmpty) {
    return 'حقل مطلوب';
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
                                initialSelectedDate: DateTime.now(), // التاريخ الابتدائي
                                onDateSelected: (selectedDate) {
                                  final formattedDate = DateFormat(
                                    'y-M-d',
                                  ).format(selectedDate); // ← 2025-4-26
                                  print('✅ التاريخ المختار: $formattedDate');
                                  controller.startDate.value = formattedDate;
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
                  duration: Duration(milliseconds: 900),
                  child: Text(
                    'تاريخ الانتهاء',
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                FadeInUp(
                  duration: Duration(milliseconds: 1000),
                  child: Obx(
                    () => TextFieldWidgets(
                      hint: controller.endDate.value.split(' ').first,
                      readOnly: true,
    validator: (value) {
  if (controller.endDate.value.isEmpty) {
    return 'حقل مطلوب';
  }

  DateTime? parseDate(String date) {
    try {
      // جرب الصيغة yyyy-MM-dd
      return DateFormat('yyyy-MM-dd').parseStrict(date);
    } catch (_) {
      try {
        // جرب الصيغة dd-MM-yyyy
        return DateFormat('dd-MM-yyyy').parseStrict(date);
      } catch (_) {
        return null;
      }
    }
  }

  final start = parseDate(controller.startDate.value);
  final end = parseDate(controller.endDate.value);

  if (start != null && end != null && end.isBefore(start)) {
    return 'تاريخ الانتهاء لا يمكن أن يكون قبل تاريخ البدء';
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
                                initialSelectedDate: DateTime.now(), // التاريخ الابتدائي
                                onDateSelected: (selectedDate) {
                                  final formattedDate = DateFormat(
                                    'y-M-d',
                                  ).format(selectedDate); // ← 2025-4-26
                                  print('✅ التاريخ المختار: $formattedDate');
                                  controller.endDate.value = formattedDate;
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
                  duration: Duration(milliseconds: 1100),
                  child: Text(
                    'وقت البدء',
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                FadeInUp(
                  duration: Duration(milliseconds: 1200),
                  child: Obx(
                    () => TextFieldWidgets(
                      hint: controller.startTime.value,
                      readOnly: true,
                      validator: (value) {
                        if (controller.startTime.value == '') {
                          return 'حقل مطلوب';
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        onPressed: () async {
                          showCupertinoModalPopup(
                            context: context,
                            builder:
                                (_) => TimePickerPopup(
                                  onTimeSelected: (DateTime newTime) {
                                    controller.selectStartTime.value = true;
                                    String formattedTime =
                                        '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}';

                                    print("الوقت المحدد: $formattedTime");
                                    controller.startTime.value = formattedTime;
                                  },
                                  onContinue: () {
                                    if (controller.selectStartTime.value == true) {
                                      Navigator.pop(context);
                                    } else {
                                      String formattedTime = DateFormat(
                                        'hh:mm',
                                      ).format(DateTime.now());
                                      controller.startTime.value = formattedTime;

                                      Navigator.pop(context);
                                    }
                                  },
                                ),
                          ).then((result) {
                            log('message $result');
                            controller.selectStartTime.value = false;
                          });
                        },
                        icon: Icon(Icons.timer_outlined, color: Color(0xFF212121), size: 24.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                FadeInUp(
                  duration: Duration(milliseconds: 1300),
                  child: Text(
                    'وقت الانتهاء',
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                FadeInUp(
                  duration: Duration(milliseconds: 1400),
                  child: Obx(
                    () => TextFieldWidgets(
                      hint: controller.endTime.value,
                      readOnly: true,
                      validator: (value) {
                        if (controller.endTime.value == '') {
                          return 'حقل مطلوب';
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        onPressed: () async {
                          showCupertinoModalPopup(
                            context: context,
                            builder:
                                (_) => TimePickerPopup(
                                  onTimeSelected: (DateTime newTime) {
                                    controller.selectEndTime.value = true;
                                    String formattedTime =
                                        '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}';

                                    print("الوقت المحدد: $formattedTime");
                                    controller.endTime.value = formattedTime;
                                  },
                                  onContinue: () {
                                    if (controller.selectEndTime.value == true) {
                                      Navigator.pop(context);
                                    } else {
                                      String formattedTime = DateFormat(
                                        'hh:mm',
                                      ).format(DateTime.now());
                                      controller.endTime.value = formattedTime;

                                      Navigator.pop(context);
                                    }

                                    // تنفيذ الإجراء عند الضغط على متابعة

                                    // أكمل الإجراء الذي تريده هنا
                                  },
                                ),
                          ).then((result) {
                            log('message $result');
                            controller.selectEndTime.value = false;
                          });
                        },
                        icon: Icon(Icons.timer_outlined, color: Color(0xFF212121), size: 24.r),
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
