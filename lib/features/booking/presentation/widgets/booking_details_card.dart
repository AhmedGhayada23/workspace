import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workspace/features/booking/presentation/widgets/booking_row_widget.dart';
import 'package:workspace/features/booking/presentation/widgets/dotted_line_widget.dart';

/// بطاقة تفاصيل الحجز (النوع/المقاعد/التواريخ/الأوقات) في شاشة التأكيد.
class BookingDetailsCard extends StatelessWidget {
  final Map<String, String> params;

  const BookingDetailsCard({super.key, required this.params});

  @override
  Widget build(BuildContext context) {
    final rows = <BookingRowWidget>[
      BookingRowWidget(title: 'نوع الحجز', value: params['subscription_id'] ?? ''),
      BookingRowWidget(title: 'عدد المقاعد', value: params['seatsCount'] ?? ''),
      BookingRowWidget(title: 'تاريخ البدء', value: (params['startDate'] ?? '').split(' ').first),
      BookingRowWidget(
          title: 'تاريخ الانتهاء', value: (params['endDate'] ?? '').split(' ').first),
      BookingRowWidget(title: 'وقت البدء', value: params['startTime'] ?? ''),
      BookingRowWidget(title: 'وقت الانتهاء', value: params['endTime'] ?? ''),
    ];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          for (int i = 0; i < rows.length; i++) ...[
            rows[i],
            if (i != rows.length - 1) const DottedLineWidget(),
          ],
        ],
      ),
    );
  }
}
