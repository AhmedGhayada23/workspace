import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/core/widgets/calendar_picker_popup.dart';
import 'package:workspace/core/widgets/time_picker_popup.dart';
import 'package:workspace/core/widgets/text_field_widget.dart';
import 'package:workspace/utils/validators.dart';

/// عنوان حقل في نموذج الحجز.
class BookingFieldLabel extends StatelessWidget {
  final String text;

  const BookingFieldLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: const Color(0xFF212121),
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

/// قائمة اختيار الاشتراك.
class SubscriptionDropdown extends StatelessWidget {
  final List<dynamic> subscriptions;
  final ValueChanged<int> onSelected;

  const SubscriptionDropdown({
    super.key,
    required this.subscriptions,
    required this.onSelected,
  });

  static String label(dynamic e) => '${e.typeTitle} - ${e.price!.split('.0').first} شيكل';

  @override
  Widget build(BuildContext context) {
    return CustomDropdown(
      hintText: 'اختر الاشتراك',
      items: subscriptions.map(label).toList(),
      onChanged: (value) {
        final selected = subscriptions.firstWhere((e) => label(e) == value);
        onSelected(selected.id! as int);
      },
      validator: (p0) => Validators.required(p0.toString()),
      decoration: CustomDropdownDecoration(
        hintStyle: GoogleFonts.tajawal(fontSize: 16.sp, color: const Color(0xFF9E9E9E)),
        headerStyle: GoogleFonts.tajawal(fontSize: 16.sp, fontWeight: FontWeight.bold),
        listItemStyle: GoogleFonts.tajawal(fontSize: 14.sp),
        closedBorderRadius: BorderRadius.circular(50.r),
        expandedBorderRadius: BorderRadius.circular(8.r),
        closedBorder: Border.all(color: const Color(0xFFF5F5F5), width: 1.r),
        expandedBorder: Border.all(color: const Color(0xFFF5F5F5), width: 1.r),
        errorStyle: GoogleFonts.tajawal(),
        closedErrorBorder: Border.all(color: const Color(0xFFF5F5F5), width: 1.r),
        closedErrorBorderRadius: BorderRadius.circular(8.r),
      ),
    );
  }
}

/// حقل اختيار تاريخ (للقراءة فقط مع تقويم منبثق).
class BookingDateField extends StatelessWidget {
  final String value;
  final ValueChanged<String> onPicked;
  final String? Function(String?) validator;

  const BookingDateField({
    super.key,
    required this.value,
    required this.onPicked,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldWidgets(
      hint: value.split(' ').first,
      readOnly: true,
      validator: validator,
      suffixIcon: IconButton(
        onPressed: () => showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => CalendarPickerPopup(
            initialSelectedDate: DateTime.now(),
            onDateSelected: (date) => onPicked(DateFormat('y-M-d').format(date)),
          ),
        ),
        icon: SvgPicture.asset(AppSvg.calendarSvg, width: 24.w, height: 24.h),
      ),
    );
  }
}

/// حقل اختيار وقت (للقراءة فقط مع منتقي وقت منبثق).
class BookingTimeField extends StatelessWidget {
  final String value;
  final ValueChanged<String> onPicked;
  final String? Function(String?) validator;

  const BookingTimeField({
    super.key,
    required this.value,
    required this.onPicked,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldWidgets(
      hint: value,
      readOnly: true,
      validator: validator,
      suffixIcon: IconButton(
        onPressed: () => showCupertinoModalPopup(
          context: context,
          builder: (_) => TimePickerPopup(
            onTimeSelected: (newTime) {
              final formatted =
                  '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}';
              onPicked(formatted);
            },
            onContinue: () => Navigator.pop(context),
          ),
        ),
        icon: Icon(Icons.timer_outlined, color: const Color(0xFF212121), size: 24.r),
      ),
    );
  }
}
