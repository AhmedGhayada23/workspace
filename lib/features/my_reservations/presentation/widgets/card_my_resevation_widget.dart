import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/core/widgets/rating_widget.dart';
import 'package:workspace/features/my_reservations/data/models/order_model.dart';
import 'package:workspace/features/profile/presentation/widgets/edit_confirmation_dialog_widget.dart';

class CardMyResevationWidget extends StatelessWidget {
  final Reservations reservations;
  final bool show;
  final Function()? onTap;
  final VoidCallback? onCancel;
  final VoidCallback? onReReserve;
  const CardMyResevationWidget({
    super.key,
    required this.show,
    required this.reservations,
    required this.onTap,
    this.onCancel,
    this.onReReserve,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.r),

        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA), // var(--w-1)
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6.r),
              child: Container(
                width: 96.w,
                height: 90.h,
                color: const Color(0xFFD9D9D9),
                child: _spaceImage(reservations.space?.mainImageUrl ?? ''),
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
                        reservations.company?.companyName ?? '',
                        style: GoogleFonts.tajawal(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF212121),
                        ),
                      ),
                      Spacer(),
                      // التاريخ
                      Text(
                          _formatDate(reservations.createdAt),
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
                        reservations.space?.address ?? '-',
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
                      SizedBox(width: 8.w),
                      show == true
                          ? InkWell(
                            onTap: () {
                              reservations.status!.id == 2 || reservations.status!.id == 4
                                  ? showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                    ),
                                    backgroundColor: Colors.white,
                                    builder: (BuildContext context) {
                                      return RatingBottomSheetWidget(id:reservations.id.toString(),reservations: reservations,);
                                    },
                                  )
                                  : reservations.status!.id == 1
                                  ? showDialog(
                                    context: context,
                                    builder:
                                        (context) => EditConfirmationDialog(
                                          title: 'هل انت متاكد ؟',
                                          subTitle: 'هل انت متاكد من ألغاء الحجز ؟',
                                          textConfirm: 'ألغاء الحجز',
                                          textConfirmColor: Color(0xFFF75555),
                                          textCanselColor: Color(0xFF000000),
                                          onConfirm: () => onCancel?.call(),
                                        ),
                                  )
                                  : showDialog(
                                    context: context,
                                    builder:
                                        (context) => EditConfirmationDialog(
                                          title: 'هل انت متاكد ؟',
                                          subTitle: 'هل انت متاكد من أعادة الحجز ؟',
                                          textConfirm: 'أعادة الحجز',
                                          textConfirmColor: AppColors.primary,
                                          textCanselColor: Color(0xFF000000),
                                          onConfirm: () => onReReserve?.call(),
                                        ),
                                  );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                color:
                                    reservations.status!.id == 2 || reservations.status!.id == 4
                                        ? Color.fromRGBO(7, 189, 116, 0.12)
                                        : reservations.status!.id == 1
                                        ? Color.fromRGBO(250, 204, 21, 0.12)
                                        : Color.fromRGBO(235, 87, 87, 0.12),
                                borderRadius: BorderRadius.circular(50.r),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    reservations.status!.id == 2 || reservations.status!.id == 4
                                        ? AppSvg.editSvg
                                        : reservations.status!.id == 1
                                        ? AppSvg.eyeSvg
                                        : AppSvg.refreshSvg,
                                    width: 16.w,
                                    height: 16.h,
                                  ),
                                  Text(
                                    reservations.status!.id == 2 || reservations.status!.id == 4
                                        ? 'تقييمك'
                                        : reservations.status!.id == 1
                                        ? 'الغاء الحجز'
                                        : 'إعادة الحجز',
                                    style: GoogleFonts.tajawal(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          reservations.status!.id == 2 ||
                                                  reservations.status!.id == 4
                                              ? Color(0xFF07BD74)
                                              : reservations.status!.id == 1
                                              ? Color(0xFFFACC15)
                                              : Color(0xFFEB5757),
                                    ),
                                  ),
                                  SizedBox(width: 6.w),
                                ],
                              ),
                            ),
                          )
                          : Container(),
                      Spacer(),
                      Text(
                        '#${reservations.startDate?.split('-').first ?? ''}${reservations.id}${reservations.status?.id}${reservations.space?.id}',
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
      ),
    );
  }
  String _formatDate(String? dateString) {
  if (dateString == null) return '';
  try {
    final date = DateTime.parse(dateString);
    return '${date.year}-${_twoDigits(date.month)}-${_twoDigits(date.day)}';
  } catch (e) {
    return '';
  }
}

String _twoDigits(int n) => n.toString().padLeft(2, '0');

  /// صورة المساحة مع بديل عند غياب الرابط أو فشل التحميل (يتجنّب NetworkImage("")).
  Widget _spaceImage(String url) {
    if (url.trim().isEmpty) return _imagePlaceholder();
    return Image.network(
      url,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (_, __, ___) => _imagePlaceholder(),
      loadingBuilder: (_, child, progress) => progress == null ? child : _imagePlaceholder(),
    );
  }

  Widget _imagePlaceholder() {
    return Center(
      child: Icon(Icons.image_outlined, color: Colors.white, size: 32.r),
    );
  }
}
