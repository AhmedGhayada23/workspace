import 'package:animate_do/animate_do.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/features/booking/controllers/confirm_booking_controller.dart';
import 'package:workspace/features/booking/presentation/widgets/booking_row_widget.dart';
import 'package:workspace/features/details_space/data/model/details_space_model.dart';
import 'package:workspace/features/my_reservations/presentation/widgets/card_my_resevation_widget.dart';

class ConfirmBookingView extends GetView<ConfirmBookingController> {
  const ConfirmBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ConfirmBookingController());
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
            'تفاصيل الحجز',
            style: GoogleFonts.tajawal(
              color: Color(0xFF212121),
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BounceInUp(
        duration: Duration(milliseconds: 500),
        child: InkWell(
          onTap: () => controller.confirmBookingProfit(),
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
                    controller.loadingProfit.isTrue
                        ? CircularProgressIndicator(color: AppColors.primary)
                        : Container(
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInUp(
                duration: Duration(milliseconds: 600),
                child: _cardSpaceDetails(space: controller.spaces),
              ),
              FadeIn(
                duration: Duration(milliseconds: 700),
                delay: Duration(milliseconds: 300),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),
                    Text(
                      'تفاصيل الحجز',
                      style: TextStyle(
                        color: Color(0xFF32B599),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 16.h),

                      decoration: BoxDecoration(
                        color: Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        children: [
                          BookingRowWidget(
                            title: 'نوع الحجز',
                            value: '${Get.parameters['subscription_id']}',
                          ),
                          DottedLineWidget(),
                          BookingRowWidget(
                            title: 'عدد المقاعد',
                            value: Get.parameters['seatsCount'].toString(),
                          ),
                          DottedLineWidget(),
                          BookingRowWidget(
                            title: 'تاريخ البدء',
                            value: Get.parameters['startDate']!.split(' ').first,
                          ),
                          DottedLineWidget(),
                          BookingRowWidget(
                            title: 'تاريخ الانتهاء',
                            value: Get.parameters['endDate']!.split(' ').first,
                          ),
                          DottedLineWidget(),
                          BookingRowWidget(
                            title: 'وقت البدء',
                            value: Get.parameters['startTime'].toString(),
                          ),
                          DottedLineWidget(),
                          BookingRowWidget(
                            title: 'وقت الانتهاء',
                            value: Get.parameters['endTime'].toString(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _cardSpaceDetails({required Spaces space}) {
  return Container(
    padding: EdgeInsets.all(8.r),

    decoration: BoxDecoration(
      color: const Color(0xFFFAFAFA), // var(--w-1)
      borderRadius: BorderRadius.circular(8.r),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 96.w,
          height: 90.h,

          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                space.mainImageUrl ??
                    'https://th.bing.com/th/id/OIP.h6tPbr6dD70MsHJaDT0XJgHaJ4?rs=1&pid=ImgDetMain',
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(6.r),
            color: const Color(0xFFD9D9D9),
            // image: DecorationImage(
            //   image: NetworkImage('<path-to-image>'),
            //   fit: BoxFit.cover,
            // ),
          ),
        ),

        /// اليسار (محتوى الحجز)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الاسم والموقع
              Row(
                children: [
                  SizedBox(width: 8.w),
                  Text(
                   space.company?.name ?? '',
                    style: GoogleFonts.tajawal(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF212121),
                    ),
                  ),
                  Spacer(),
                  // التاريخ
                  Text(
                    DateFormat('dd-MM-yyyy').format(DateTime.now()),
                    style: GoogleFonts.tajawal(
                      fontSize: 12.sp,
                      color: Color(0xFF757575),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  SizedBox(width: 8.w),
                  SvgPicture.asset(
                    AppSvg.locationSvg,
                    width: 16.w,
                    height: 16.h,
                    color: Color(0xFF757575),
                  ),
                  Text(
                    space.address ?? '-',
                    style: GoogleFonts.tajawal(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF757575),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),
              // رقم الحجز والزر
              Row(
                children: [
                  Container(),
                  Spacer(),
                  Text(
                    '#${space.createdAt?.split('-').first}099${space.id}',
                    style: GoogleFonts.tajawal(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF212121),
                    ),
                  ),
                  SizedBox(width: 12.w),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class DottedLineWidget extends StatelessWidget {
  const DottedLineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 16),
      decoration: DottedDecoration(
        shape: Shape.line,
        linePosition: LinePosition.bottom,
        color: Color(0xFFBDBDBD),
        dash: [4, 4],
      ),
    );
  }
}
