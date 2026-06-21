import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/navigation/app_navigator.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/widgets/text_field_widget.dart';
import 'package:workspace/features/booking/presentation/cubit/booking/booking_cubit.dart';
import 'package:workspace/features/booking/presentation/widgets/booking_form_fields.dart';
import 'package:workspace/features/booking/presentation/widgets/booking_submit_bar.dart';
import 'package:workspace/features/details_space/data/model/details_space_model.dart';
import 'package:workspace/utils/validators.dart';

class BookingView extends StatelessWidget {
  final Spaces space;
  final List<dynamic> subscriptions;
  final String spaceId;
  final String isProfit;

  const BookingView({
    super.key,
    required this.space,
    required this.subscriptions,
    required this.spaceId,
    required this.isProfit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<BookingCubit>(),
      child: _BookingBody(
        space: space,
        subscriptions: subscriptions,
        spaceId: spaceId,
        isProfit: isProfit,
      ),
    );
  }
}

class _BookingBody extends StatefulWidget {
  final Spaces space;
  final List<dynamic> subscriptions;
  final String spaceId;
  final String isProfit;

  const _BookingBody({
    required this.space,
    required this.subscriptions,
    required this.spaceId,
    required this.isProfit,
  });

  @override
  State<_BookingBody> createState() => _BookingBodyState();
}

class _BookingBodyState extends State<_BookingBody> {
  final _nav = sl<AppNavigator>();
  final _formKey = GlobalKey<FormState>();
  final _seatsController = TextEditingController();

  @override
  void dispose() {
    _seatsController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final state = context.read<BookingCubit>().state;
    _nav.toConfirmBooking(
      arguments: widget.space,
      parameters: {
        'id': widget.spaceId,
        'is_profit': widget.isProfit,
        'subscription_id': state.subscriptionId.toString(),
        'startDate': state.startDate,
        'endDate': state.endDate,
        'startTime': state.startTime,
        'endTime': state.endTime,
        'seatsCount': _seatsController.text,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookingCubit>();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          onPressed: _nav.back,
          icon: Icon(Icons.arrow_back, size: 24.r, color: const Color(0xFF212121)),
        ),
        centerTitle: true,
        title: Text(
          'طلب حجز',
          style: GoogleFonts.tajawal(
            color: const Color(0xFF212121),
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      bottomNavigationBar: BookingSubmitBar(label: 'ارسل الحجز', onTap: _submit),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: BlocBuilder<BookingCubit, BookingState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BookingFieldLabel('نوع الاشتراك'),
                    SizedBox(height: 8.h),
                    SubscriptionDropdown(
                      subscriptions: widget.subscriptions,
                      onSelected: cubit.setSubscription,
                    ),
                    SizedBox(height: 16.h),
                    const BookingFieldLabel('عدد المقاعد'),
                    SizedBox(height: 8.h),
                    TextFieldWidgets(
                      controller: _seatsController,
                      hint: '',
                      keyboardType: TextInputType.number,
                      validator: Validators.positiveInteger,
                    ),
                    SizedBox(height: 16.h),
                    const BookingFieldLabel('تاريخ البدء'),
                    SizedBox(height: 8.h),
                    BookingDateField(
                      value: state.startDate,
                      onPicked: cubit.setStartDate,
                      validator: (_) => state.startDate.isEmpty ? 'حقل مطلوب' : null,
                    ),
                    SizedBox(height: 16.h),
                    const BookingFieldLabel('تاريخ الانتهاء'),
                    SizedBox(height: 8.h),
                    BookingDateField(
                      value: state.endDate,
                      onPicked: cubit.setEndDate,
                      validator: (_) => _validateEndDate(state),
                    ),
                    SizedBox(height: 16.h),
                    const BookingFieldLabel('وقت البدء'),
                    SizedBox(height: 8.h),
                    BookingTimeField(
                      value: state.startTime,
                      onPicked: cubit.setStartTime,
                      validator: (_) => state.startTime.isEmpty ? 'حقل مطلوب' : null,
                    ),
                    SizedBox(height: 16.h),
                    const BookingFieldLabel('وقت الانتهاء'),
                    SizedBox(height: 8.h),
                    BookingTimeField(
                      value: state.endTime,
                      onPicked: cubit.setEndTime,
                      validator: (_) => _validateEndTime(state),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  DateTime? _parseDate(String d) {
    try {
      return DateFormat('yyyy-MM-dd').parseStrict(d);
    } catch (_) {
      try {
        return DateFormat('dd-MM-yyyy').parseStrict(d);
      } catch (_) {
        return null;
      }
    }
  }

  String? _validateEndDate(BookingState state) {
    if (state.endDate.isEmpty) return 'حقل مطلوب';
    final start = _parseDate(state.startDate);
    final end = _parseDate(state.endDate);
    if (start != null && end != null && end.isBefore(start)) {
      return 'تاريخ الانتهاء لا يمكن أن يكون قبل تاريخ البدء';
    }
    return null;
  }

  /// وقت الانتهاء يجب أن يكون بعد وقت البدء (عند تطابق التاريخين). الصيغة "HH:mm".
  String? _validateEndTime(BookingState state) {
    if (state.endTime.isEmpty) return 'حقل مطلوب';
    if (state.startTime.isEmpty) return null;

    final start = _parseDate(state.startDate);
    final end = _parseDate(state.endDate);
    // إن كان تاريخ الانتهاء بعد تاريخ البدء فلا قيد على الوقت.
    if (start != null && end != null && end.isAfter(start)) return null;

    int? minutes(String t) {
      final parts = t.split(':');
      if (parts.length != 2) return null;
      final h = int.tryParse(parts[0]);
      final m = int.tryParse(parts[1]);
      if (h == null || m == null) return null;
      return h * 60 + m;
    }

    final s = minutes(state.startTime);
    final e = minutes(state.endTime);
    if (s != null && e != null && e <= s) {
      return 'وقت الانتهاء يجب أن يكون بعد وقت البدء';
    }
    return null;
  }
}
