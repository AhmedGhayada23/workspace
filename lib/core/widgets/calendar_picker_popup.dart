import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarPickerPopup extends StatefulWidget {
  final DateTime? initialSelectedDate;
  final Function(DateTime selectedDate) onDateSelected;
  final bool enableYearPicker;

  const CalendarPickerPopup({
    super.key,
    required this.initialSelectedDate,
    required this.onDateSelected,
    this.enableYearPicker = false,
  });

  @override
  _CalendarPickerPopupState createState() => _CalendarPickerPopupState();
}

class _CalendarPickerPopupState extends State<CalendarPickerPopup> {
  late DateTime focusedDay;
  DateTime? tempSelected;
  late DateTime lastAllowedDate;
  final int startYear = 1950;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    lastAllowedDate = DateTime(now.year, 12, 31);
    final initial = widget.initialSelectedDate ?? now;
    focusedDay = getOnlyDate(initial.isAfter(lastAllowedDate) ? lastAllowedDate : initial);
    tempSelected = focusedDay;
  }

  DateTime getOnlyDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  @override
  Widget build(BuildContext context) {
    int currentYear = DateTime.now().year;

    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      contentPadding: const EdgeInsets.all(16),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'حدد التاريخ',
                textAlign: TextAlign.center,
                style: GoogleFonts.tajawal(
                  color: const Color(0xFF212121),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 12.h),

              if (widget.enableYearPicker)
                SizedBox(
                  height: 100.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: currentYear - startYear + 1,
                    itemBuilder: (context, index) {
                      int year = startYear + index;
                      bool isSelected = focusedDay.year == year;
                      return InkWell(
                        onTap: () {
                          final updatedDate = DateTime(year, focusedDay.month, 1);
                          if (!updatedDate.isAfter(lastAllowedDate)) {
                            setState(() {
                              focusedDay = updatedDate;
                              tempSelected = updatedDate;
                            });
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF3DC39D)
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Center(
                            child: Text(
                              '$year',
                              style: GoogleFonts.tajawal(
                                color: isSelected ? Colors.white : Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

              TableCalendar(
                firstDay: DateTime(startYear, 1, 1),
                lastDay: lastAllowedDate,
                focusedDay: focusedDay,
                selectedDayPredicate: (day) => isSameDay(tempSelected, day),
                onDaySelected: (selectedDay, newFocusedDay) {
                  if (!selectedDay.isAfter(lastAllowedDate)) {
                    setState(() {
                      tempSelected = selectedDay;
                      focusedDay = newFocusedDay;
                    });
                  }
                },
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: const Color(0xFF3DC39D),
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  outsideTextStyle: TextStyle(color: Colors.grey[400]),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextFormatter: (date, locale) =>
                      DateFormat.yMMMM().format(date),
                  titleTextStyle: GoogleFonts.tajawal(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  leftChevronIcon: const Icon(Icons.chevron_left),
                  rightChevronIcon: const Icon(Icons.chevron_right),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: const TextStyle(color: Colors.black),
                  weekendStyle: const TextStyle(color: Colors.black),
                ),
              ),

              SizedBox(height: 16.h),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (tempSelected != null &&
                            !tempSelected!.isAfter(lastAllowedDate)) {
                          widget.onDateSelected(tempSelected!);
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(133.w, 44.h),
                        backgroundColor: const Color(0xFF3DC39D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        'متابعة',
                        style: GoogleFonts.tajawal(
                          color: const Color(0xFFFAFAFA),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'إلغاء',
                        style: GoogleFonts.tajawal(
                          color: const Color(0xFFF75555),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
