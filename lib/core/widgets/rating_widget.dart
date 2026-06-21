import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:workspace/core/navigation/app_navigator.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/core/widgets/text_field_widget.dart';
import 'package:workspace/features/my_reservations/data/models/order_model.dart';
import 'package:workspace/features/my_reservations/presentation/widgets/card_my_resevation_widget.dart';
import 'package:workspace/features/rating/presentation/cubit/rating_cubit.dart';

class RatingBottomSheetWidget extends StatelessWidget {
  final String id;
  final Reservations reservations;

  const RatingBottomSheetWidget({super.key, required this.reservations, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RatingCubit>(),
      child: _RatingBody(reservations: reservations, id: id),
    );
  }
}

class _RatingBody extends StatefulWidget {
  final String id;
  final Reservations reservations;

  const _RatingBody({required this.reservations, required this.id});

  @override
  State<_RatingBody> createState() => _RatingBodyState();
}

class _RatingBodyState extends State<_RatingBody> {
  final _nav = sl<AppNavigator>();
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _submit() {
    context.read<RatingCubit>().submit(
          reservationId: int.tryParse(widget.id) ?? 0,
          message: _noteController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RatingCubit>();
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: SingleChildScrollView(
        child: BlocConsumer<RatingCubit, RatingState>(
          listenWhen: (p, c) => p.status != c.status,
          listener: (context, state) {
            // النجاح فقط عبر snackbar (بعد إغلاق الـ sheet)؛ الخطأ يُعرض داخل الـ sheet.
            if (state.status == RatingStatus.success) {
              _nav.back();
              showCustomSnackBar(context, state.message, SnackBarType.success);
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: _nav.back,
                      icon: Icon(Icons.arrow_back, size: 24.r, color: AppColors.black),
                    ),
                    Text(
                      'تفاصيل الحجز',
                      style: TextStyle(
                        color: const Color(0xFF212121),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(),
                  ],
                ),
                // لافتة خطأ ظاهرة داخل الـ sheet (أمام المستخدم مباشرةً).
                if (state.status == RatingStatus.failure && state.message.isNotEmpty) ...[
                  SizedBox(height: 12.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDEDF0),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: const Color(0xFFF75555), width: .6),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline_rounded,
                            color: const Color(0xFFF75555), size: 18.r),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            state.message,
                            style: GoogleFonts.tajawal(
                              color: const Color(0xFFDF1C41),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                SizedBox(height: 24.h),
                CardMyResevationWidget(onTap: () {}, reservations: widget.reservations, show: false),
                SizedBox(height: 24.h),
                RatingItemWidget(
                  title: 'سرعة الانترنت',
                  onRatingUpdate: (value) => cubit.setRating('internet', value.toInt()),
                ),
                SizedBox(height: 24.h),
                RatingItemWidget(
                  title: 'الكهرباء',
                  onRatingUpdate: (value) => cubit.setRating('electricity', value.toInt()),
                ),
                SizedBox(height: 24.h),
                RatingItemWidget(
                  title: 'واخرى',
                  onRatingUpdate: (value) => cubit.setRating('other', value.toInt()),
                ),
                SizedBox(height: 24.h),
                Text(
                  'اكتب تعليقك',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.tajawal(
                    color: const Color(0xFF212121),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 16.h),
                TextFieldWidgets(
                  controller: _noteController,
                  hint: 'أكتب تعليق',
                  maxLines: 5,
                  radius: 8,
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: state.status == RatingStatus.loading
                          ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                          : GestureDetector(
                              onTap: _submit,
                              child: Container(
                                height: 44.h,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF32B599),
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
                    SizedBox(width: 16.w),
                    GestureDetector(
                      onTap: _nav.back,
                      child: Container(
                        height: 40.h,
                        padding: EdgeInsets.symmetric(horizontal: 32.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        child: Center(
                          child: Text(
                            'الغاء',
                            style: GoogleFonts.tajawal(
                              color: const Color(0xFFF75555),
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
            );
          },
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
            color: const Color(0xFF212121),
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
            empty: SvgPicture.asset(AppSvg.starSvg, color: const Color(0xffd8d8d8)),
            full: SvgPicture.asset(AppSvg.starSvg),
            half: SvgPicture.asset(AppSvg.starSvg),
          ),
          onRatingUpdate: onRatingUpdate,
        ),
      ],
    );
  }
}
