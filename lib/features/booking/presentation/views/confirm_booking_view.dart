import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:workspace/core/navigation/app_navigator.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/widgets/booking_success_popup_widget.dart';
import 'package:workspace/features/booking/domain/usecases/confirm_booking_usecase.dart';
import 'package:workspace/features/booking/presentation/cubit/confirm_booking/confirm_booking_cubit.dart';
import 'package:workspace/features/booking/presentation/widgets/booking_details_card.dart';
import 'package:workspace/features/booking/presentation/widgets/booking_space_card.dart';
import 'package:workspace/features/booking/presentation/widgets/booking_submit_bar.dart';
import 'package:workspace/features/details_space/data/model/details_space_model.dart';

class ConfirmBookingView extends StatelessWidget {
  final Spaces space;
  final Map<String, String> params;

  const ConfirmBookingView({super.key, required this.space, required this.params});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ConfirmBookingCubit>(),
      child: _ConfirmBookingBody(space: space, params: params),
    );
  }
}

class _ConfirmBookingBody extends StatelessWidget {
  final Spaces space;
  final Map<String, String> params;

  const _ConfirmBookingBody({required this.space, required this.params});

  void _onState(BuildContext context, ConfirmBookingState state) {
    if (state.status == ConfirmBookingStatus.success) {
      context.read<ConfirmBookingCubit>().reset();
      showDialog(context: context, builder: (_) => const BookingSuccessPopup());
    } else if (state.status == ConfirmBookingStatus.failure) {
      context.read<ConfirmBookingCubit>().reset();
      showCustomSnackBar(context, state.errorMessage, SnackBarType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final nav = sl<AppNavigator>();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          onPressed: nav.back,
          icon: Icon(Icons.arrow_back, size: 24.r, color: const Color(0xFF212121)),
        ),
        centerTitle: true,
        title: Text(
          'تفاصيل الحجز',
          style: GoogleFonts.tajawal(
            color: const Color(0xFF212121),
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      bottomNavigationBar: BlocConsumer<ConfirmBookingCubit, ConfirmBookingState>(
        listener: _onState,
        builder: (context, state) {
          return BookingSubmitBar(
            label: 'ارسل الحجز',
            isLoading: state.status == ConfirmBookingStatus.loading,
            onTap: () => context
                .read<ConfirmBookingCubit>()
                .confirm(ConfirmBookingParams.fromMap(params)),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookingSpaceCard(space: space),
              SizedBox(height: 24.h),
              Text(
                'تفاصيل الحجز',
                style: TextStyle(
                  color: const Color(0xFF32B599),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16.h),
              BookingDetailsCard(params: params),
            ],
          ),
        ),
      ),
    );
  }
}
