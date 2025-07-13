import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/features/Home/presentation/widgets/loading_home.dart';
import 'package:workspace/features/my_reservations/controllers/details_my_reservation.dart';
import 'package:animate_do/animate_do.dart';
import 'package:workspace/features/my_reservations/presentation/widgets/card_my_resevation_widget.dart';
import 'package:workspace/features/my_reservations/presentation/widgets/loading_details_my_reservation.dart';
import 'package:workspace/features/my_reservations/presentation/widgets/loading_my_reservation.dart';
import 'package:workspace/features/my_reservations/presentation/widgets/non_profit_booking_details_widget.dart';
import 'package:workspace/features/my_reservations/presentation/widgets/profit_booking_details_widget.dart';

class DetailsMyReservationView extends GetView<DetailsMyResevationController> {
  const DetailsMyReservationView({super.key});

  @override
  Widget build(BuildContext context) {
    int index = int.parse(Get.parameters['index'] ?? '0');
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: AppColors.black, size: 24.w),
        ),
        title: FadeInDown(
          duration: Duration(milliseconds: 500),
          child: Text(
            'تفاصيل الحجز',
            style: GoogleFonts.tajawal(
              color: Color(0xFF212121),
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              height: 1.0,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                ()=> controller.loading .isTrue ?
                LoadingMyReservation().cardShimmerMyResevation :
                 FadeIn(
                  duration: Duration(milliseconds: 600),
                  child: CardMyResevationWidget(
                    onTap: (){},
                    reservations: controller.reservations,
                    show: false,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Obx(
                ()=> controller.loading.isTrue ? HomeShimmerView().sectionHeader

                 : controller.reservations.status!.id == 2 ?   FadeInUp(
                  duration: Duration(milliseconds: 700),
                  child: Text(
                    'تفاصيل الحجز',
                    style: TextStyle(
                      color: Color(0xFF32B599),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ) : SizedBox.shrink(),
              ),
              SizedBox(height: 16.h),
              controller.reservations.status!.id == 1 ?

              Obx(
               ()=> controller.loading.isTrue ?
                LoadingDetailsMyReservation().buildShimmerPeriodDetails() :
                buildCustomInfoCard(
                  iconColor : Color(0xFFFACC15),
                  background: Color.fromRGBO(250, 204, 21, 0.12),
                  infoText: 'طلبك قيد المراجعة من الادارة سيتم ابلاغك في حال الموافقة على الطلب',
                ),
              ) :
        controller.reservations.status!.id!  > 2 ?
        Obx(
          ()=> controller.loading.isTrue ?
           LoadingDetailsMyReservation().buildShimmerPeriodDetails() :
           buildCustomInfoCard
          (infoText: controller.reservations.note ?? 'تم الغاء الحجز من قبلك ',
          background: Color(0xffFDEDF0),
          iconColor: Color(0xffDF1C41)),
        ) :

             Obx(
               ()=> controller.loading.isTrue ?
               LoadingDetailsMyReservation().buildShimmerPeriodDetails() :

                controller.dataReservationDetatials.value!.data!.reservation!.intervals!.isNotEmpty  ?


                   FadeIn(
                    duration: Duration(milliseconds: 800),
                    child: NonProfitBookingDetailWidget(
                      intervals: controller.dataReservationDetatials.value!.data!.reservation!.intervals!,
                      room: controller.dataReservationDetatials.value!.data!.reservation!.room!,
                    ),

                ) :  FadeIn(
                    duration: Duration(milliseconds: 800),
                    child: ProfitBookingDetailsWidget(
                      reservation: controller.dataReservationDetatials.value!.data!.reservation!,
                      subscription : controller.dataReservationDetatials.value!.data!.reservation!.subscription!,
                    )),

             ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCustomInfoCard({
  required String infoText,
   Color background = const Color(0xffEBF1FF),
   Color iconColor = const Color(0xff375DFB),
  }){
    return Container(

      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color:iconColor,
            width: .3,
          )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 8.w,
          ),
          SvgPicture.asset(
            'assets/svg/fill_info.svg',
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            width: 24.w,
            height: 24.h,

          ),
          SizedBox(
            width: 8.w,
          ),
          SizedBox(
            width: 316.w,
            child: Text(
              infoText,
              style: GoogleFonts.tajawal(
                    fontSize: 14.sp,
              ),
            ),
          )
        ],
      ),
    );
  }
    Widget buildDetailRow(String title, String value) {
    return Row(
      children: [
        SizedBox(
          width: 100.w,
          child: Text(
            title,
            style: GoogleFonts.tajawal(
              color: Color(0xFF9E9E9E),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.tajawal(
              color: Color(0xFF212121),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
