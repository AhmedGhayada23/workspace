import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/core/widgets/text_field_widget.dart';
import 'package:workspace/features/my_reservations/data/models/order_model.dart';

import 'package:workspace/features/my_reservations/presentation/widgets/card_my_resevation_widget.dart';
import 'package:workspace/features/rating/controller/rating_controller.dart';

class RatingBottomSheetWidget extends StatelessWidget {
  final String id;
  final Reservations reservations;

  const RatingBottomSheetWidget({super.key,
  required this.reservations,
   required this.id});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RatingController());

    return Padding(
      padding: EdgeInsets.all(16.r),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // العنوان والرجوع
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.arrow_back, size: 24.r, color: AppColors.black),
                ),
                Text(
                  'تفاصيل الحجز',
                  style: TextStyle(
                    color: Color(0xFF212121),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(), // للموازنة فقط
              ],
            ),
            SizedBox(height: 24.h),

            CardMyResevationWidget(onTap: () {}, reservations: reservations, show: false),
            SizedBox(height: 24.h),

            RatingItemWidget(
              title: 'سرعة الانترنت',
              onRatingUpdate: (value) {
                controller.evaluations.add({'type': 'internet', 'value': value.toInt().toString()});
              },
            ),
            SizedBox(height: 24.h),

            RatingItemWidget(
              title: 'الكهرباء',
              onRatingUpdate: (value) {
                controller.evaluations.add({
                  'type': 'electricity',
                  'value': value.toInt().toString(),
                });
              },
            ),
            SizedBox(height: 24.h),

            RatingItemWidget(
              title: 'واخرى',
              onRatingUpdate: (value) {
                controller.evaluations.add({'type': 'other', 'value': value.toInt().toString()});
              },
            ),

            SizedBox(height: 24.h),

            Text(
              'اكتب تعليقك',
              textAlign: TextAlign.right,
              style: GoogleFonts.tajawal(
                color: Color(0xFF212121),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16.h),

            TextFieldWidgets(
              controller: controller.noteTextEditingController,
              hint: 'أكتب تعليق',
              maxLines: 5,
              radius: 8,
            ),
            SizedBox(height: 24.h),

            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Obx(
                    () =>
                        controller.loading.isTrue
                            ? Center(child: CircularProgressIndicator(color: AppColors.primary))
                            : GestureDetector(
                              onTap: () => controller.submitRatings(id),
                              child: Container(
                                height: 44.h,
                                decoration: BoxDecoration(
                                  color: Color(0xFF32B599),
                                  borderRadius: BorderRadius.circular(50.r),
                                ),
                                child: Center(
                                  child: Text(
                                    'اضف تقييمك',
                                    style: GoogleFonts.tajawal(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                  ),
                ),
                SizedBox(width: 16.w),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    height: 40.h,
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Center(
                      child: Text(
                        'الغاء',
                        style: GoogleFonts.tajawal(
                          color: Color(0xFFF75555),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RatingItemWidget extends StatelessWidget {
  final String title;
  final void Function(double) onRatingUpdate;

  const RatingItemWidget({super.key, required this.title, required this.onRatingUpdate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.right,
          style: GoogleFonts.tajawal(
            color: Color(0xFF212121),
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            height: 1.0,
          ),
        ),
        SizedBox(height: 4.h),
        RatingBar(
          initialRating: 0,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 2.0.w),
          itemSize: 32.r,
          ratingWidget: RatingWidget(
            empty: SvgPicture.asset(AppSvg.starSvg, color: Color(0xffd8d8d8)),
            full: SvgPicture.asset(AppSvg.starSvg),
            half: SvgPicture.asset(AppSvg.starSvg),
          ),
          onRatingUpdate: onRatingUpdate,
        ),
      ],
    );
  }
}
