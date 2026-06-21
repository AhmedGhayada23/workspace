import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/features/details_space/data/model/details_space_model.dart';

class InformationAboutSpaceWidget extends StatelessWidget {
  final String nameSpace;
  final String typeTitle;
  final String ratingCount;
  final String ratingAverage;
  final String address;
  final String available;
  final String mobile;
  final String email;
  final String customersCount;
  final String nameCompany;
  final String imageCompany;

  const InformationAboutSpaceWidget({
    super.key,
    required this.nameSpace,
    required this.typeTitle,
    required this.ratingCount,
    required this.ratingAverage,
    required this.address,
    required this.available,
    required this.mobile,
    required this.email,
    required this.customersCount,
    required this.nameCompany,
    required this.imageCompany,
  });

  /// يبني الـ widget مباشرة من كائن [Spaces].
  factory InformationAboutSpaceWidget.fromSpace(Spaces space, String available) {
    return InformationAboutSpaceWidget(
      nameSpace: space.company?.name ?? '-',
      typeTitle: space.company?.typeTitle ?? '-',
      ratingCount: '${space.customerRatingAverages?.length ?? '0'}',
      ratingAverage: '${space.ratingAverage ?? '0'}',
      address: space.address ?? '-',
      available: available,
      mobile: space.mobile ?? '-',
      email: space.email ?? '-',
      customersCount: '${space.customersCount ?? '0'}',
      nameCompany: space.company?.user?.name ?? '-',
      imageCompany: space.company?.imageUrl ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 17.h),
        _header(),
        SizedBox(height: 24.h),
        _InfoRow(icon: AppSvg.locationSvg, text: address),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(child: _InfoRow(icon: AppSvg.clockSvg, text: available)),
            SizedBox(width: 8.w),
            Expanded(
              child: _InfoRow(
                icon: AppSvg.mdiPhoneOutlineSvg,
                text: mobile,
                ltr: true,
                copyLabel: 'تم نسخ رقم الهاتف',
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: _InfoRow(
                icon: AppSvg.smsSvg,
                text: email,
                copyLabel: 'تم نسخ البريد الإلكتروني',
              ),
            ),
            Expanded(child: _InfoRow(icon: AppSvg.usersSvg, text: '$customersCount مشترك')),
          ],
        ),
        SizedBox(height: 24.h),
        Text(
          'مدير المساحة',
          style: GoogleFonts.tajawal(
            color: const Color(0xFF32B599),
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        _ManagerTile(name: nameCompany, imageUrl: imageCompany),
      ],
    );
  }

  Widget _header() {
    return Row(
      children: [
        Flexible(
          child: Text(
            nameSpace,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.tajawal(
              color: const Color(0xFF212121),
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Container(
          padding: EdgeInsets.all(4.r),
          decoration: BoxDecoration(
            color: const Color(0xFF32B599),
            borderRadius: BorderRadius.circular(50.r),
          ),
          child: Text(
            'مساحة $typeTitle',
            style: GoogleFonts.tajawal(
              color: const Color(0xFFFAFAFA),
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const Spacer(),
        SvgPicture.asset(AppSvg.starSvg, width: 20.w, height: 20.h),
        SizedBox(width: 4.w),
        Text(
          ratingAverage,
          style: GoogleFonts.tajawal(
            color: const Color(0xFF171725),
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(width: 2.w),
        Text(
          '($ratingCount مقيم)',
          style: GoogleFonts.tajawal(
            color: const Color(0xFF66707A),
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

/// صف "أيقونة + نص" المتكرّر في معلومات المساحة.
class _InfoRow extends StatelessWidget {
  final String icon;
  final String text;
  final bool ltr;

  /// عند تمريرها يصبح الصف قابلاً للنسخ بالضغط (للهاتف/البريد) مع أيقونة نسخ.
  final String? copyLabel;

  const _InfoRow({required this.icon, required this.text, this.ltr = false, this.copyLabel});

  @override
  Widget build(BuildContext context) {
    final row = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(icon, width: 18.w, height: 18.h, color: const Color(0xFF616161)),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            textDirection: ltr ? TextDirection.ltr : null,
            style: GoogleFonts.tajawal(
              color: const Color(0xFF616161),
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        if (copyLabel != null) ...[
          SizedBox(width: 4.w),
          Icon(Icons.copy_rounded, size: 14.r, color: const Color(0xFF32B599)),
        ],
      ],
    );

    if (copyLabel == null) return row;
    return InkWell(
      onTap: () {
        Clipboard.setData(ClipboardData(text: text));
        showCustomSnackBar(context, copyLabel!, SnackBarType.success);
      },
      child: row,
    );
  }
}

class _ManagerTile extends StatelessWidget {
  final String name;
  final String imageUrl;

  const _ManagerTile({required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 50.r,
        height: 50.r,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFE3F4F0),
        ),
        child: imageUrl.isEmpty
            ? _placeholder()
            : CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => _placeholder(),
                errorWidget: (context, url, error) => _placeholder(),
              ),
      ),
      title: Text(
        name,
        style: GoogleFonts.tajawal(
          color: const Color(0xFF212121),
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Padding(
      padding: EdgeInsets.all(12.r),
      child: SvgPicture.asset(
        AppSvg.profileSvg,
        colorFilter: const ColorFilter.mode(Color(0xFF32B599), BlendMode.srcIn),
      ),
    );
  }
}
