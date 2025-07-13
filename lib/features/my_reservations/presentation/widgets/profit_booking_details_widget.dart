import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/features/booking/presentation/views/confirm_booking_view.dart';
import 'package:workspace/features/booking/presentation/widgets/booking_row_widget.dart';
import 'package:workspace/features/my_reservations/data/models/details_resevation_model.dart';

class ProfitBookingDetailsWidget extends StatelessWidget {
  final Reservation reservation;
  final Subscription? subscription;
  const ProfitBookingDetailsWidget({super.key, required this.reservation,required this.subscription});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),

          decoration: BoxDecoration(
            color: Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            children: [
              BookingRowWidget(title: 'نوع الاشتراك', value: subscription?.typeTitle ?? ''),
              DottedLineWidget(),
              BookingRowWidget(title: 'عدد المقاعد', value: '${reservation.seatsCount ?? 0}'),
              DottedLineWidget(),
              BookingRowWidget(title: 'تاريخ البدء', value: reservation.startDate ?? ''),
              DottedLineWidget(),
              BookingRowWidget(title: 'تاريخ الانتهاء', value: reservation.endDate ?? ''),
              DottedLineWidget(),
              BookingRowWidget(title: 'وقت البدء', value: formatTime(reservation.startTime ?? '')),
              DottedLineWidget(),
              BookingRowWidget(title: 'وقت الانتهاء', value: formatTime(reservation.endTime ?? '')),
            ],
          ),
        ),
      ],
    );
  }
}

String formatTime(String isoDate) {
  final dateTime = DateTime.parse(isoDate).toLocal();
  final hour = dateTime.hour;
  final minute = dateTime.minute.toString().padLeft(2, '0');
  final suffix = hour >= 12 ? 'م' : 'ص';

  final formattedHour = hour % 12 == 0 ? 12 : hour % 12;
  return '$formattedHour:$minute $suffix';
}
