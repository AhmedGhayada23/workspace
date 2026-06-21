import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/navigation/app_navigator.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/features/my_reservations/data/models/order_model.dart';
import 'package:workspace/features/my_reservations/presentation/cubit/details_reservation/details_reservation_cubit.dart';
import 'package:workspace/features/my_reservations/presentation/widgets/card_my_resevation_widget.dart';
import 'package:workspace/features/my_reservations/presentation/widgets/non_profit_booking_details_widget.dart';
import 'package:workspace/features/my_reservations/presentation/widgets/profit_booking_details_widget.dart';

/// حجز وهمي يُعرض كهيكل عظمي أثناء التحميل.
final _fakeReservation = Reservations.fromJson({
  'id': 0,
  'start_date': '2026-01-01',
  'created_at': '2026-01-01',
  'status': {'id': 2},
  'space': {'id': 0, 'address': 'غزة - شارع الجلاء', 'main_image_url': ''},
  'company': {'company_name': 'شركة المساحات اريستو'},
});

class DetailsMyReservationView extends StatelessWidget {
  final Reservations reservation;

  const DetailsMyReservationView({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DetailsReservationCubit>()..load(reservation),
      child: const _DetailsBody(),
    );
  }
}

class _DetailsBody extends StatelessWidget {
  const _DetailsBody();

  @override
  Widget build(BuildContext context) {
    final nav = sl<AppNavigator>();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: nav.back,
          icon: Icon(Icons.arrow_back, color: AppColors.black, size: 24.w),
        ),
        title: Text(
          'تفاصيل الحجز',
          style: GoogleFonts.tajawal(
            color: const Color(0xFF212121),
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: BlocBuilder<DetailsReservationCubit, DetailsReservationState>(
            builder: (context, state) {
              final loading = state.status != DetailsReservationStatus.loaded;
              final reservation = state.reservation;
              final statusId = reservation?.status?.id ?? 0;
              return Skeletonizer(
                enabled: loading,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CardMyResevationWidget(
                      onTap: () {},
                      reservations: loading ? _fakeReservation : reservation!,
                      show: false,
                    ),
                    SizedBox(height: 24.h),
                    if (loading || statusId == 2)
                      Text(
                        'تفاصيل الحجز',
                        style: TextStyle(
                          color: const Color(0xFF32B599),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    SizedBox(height: 16.h),
                    if (loading) _loadingDetails() else _content(state, statusId),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _content(DetailsReservationState state, int statusId) {
    if (statusId == 1) {
      return _infoCard(
        infoText: 'طلبك قيد المراجعة من الادارة سيتم ابلاغك في حال الموافقة على الطلب',
        background: const Color.fromRGBO(250, 204, 21, 0.12),
        iconColor: const Color(0xFFFACC15),
      );
    }
    if (statusId > 2) {
      // ملاحظة الرفض تأتي من المساحة عبر status.note (من التفاصيل المجلوبة أولاً).
      final rejectNote = (state.details?.data?.reservation?.status?.note?.trim().isNotEmpty ?? false)
          ? state.details!.data!.reservation!.status!.note!.trim()
          : (state.reservation?.status?.note?.trim() ?? '');
      final infoText = rejectNote.isNotEmpty
          ? 'تم رفض الحجز من المساحة.\nالسبب: $rejectNote'
          : 'تم الغاء الحجز من قبلك ';
      return _infoCard(
        infoText: infoText,
        background: const Color(0xffFDEDF0),
        iconColor: const Color(0xffDF1C41),
      );
    }
    final reservation = state.details?.data?.reservation;
    if (reservation == null) return const SizedBox.shrink();
    return (reservation.intervals?.isNotEmpty ?? false)
        ? NonProfitBookingDetailWidget(
            intervals: reservation.intervals!,
            room: reservation.room!,
          )
        : ProfitBookingDetailsWidget(
            reservation: reservation,
            subscription: reservation.subscription!,
          );
  }

  /// محتوى وهمي لتفاصيل الحجز أثناء التحميل (يلفّه Skeletonizer).
  Widget _loadingDetails() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: List.generate(
          6,
          (_) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              children: [
                SizedBox(
                  width: 100.w,
                  child: Text('العنوان', style: GoogleFonts.tajawal(fontSize: 14.sp)),
                ),
                Expanded(
                  child: Text('قيمة وهمية للعرض', style: GoogleFonts.tajawal(fontSize: 14.sp)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoCard({
    required String infoText,
    Color background = const Color(0xffEBF1FF),
    Color iconColor = const Color(0xff375DFB),
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: iconColor, width: .3),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 8.w),
          SvgPicture.asset(
            'assets/svg/fill_info.svg',
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            width: 24.w,
            height: 24.h,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(infoText, style: GoogleFonts.tajawal(fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }
}
