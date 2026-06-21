import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/features/notification/data/model/notification_model.dart';

class NotificationItemWidget extends StatelessWidget {
  final Notifications notification;
  final String timeAgo;
  final VoidCallback onTap;

  const NotificationItemWidget({
    super.key,
    required this.notification,
    required this.timeAgo,
    required this.onTap,
  });

  /// يزيل وسوم HTML ويوحّد المسافات (نصوص الإشعارات قد تأتي بـ HTML طويل).
  String _cleanBody(String raw) {
    return raw
        .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), ' ')
        .replaceAll(RegExp(r'<[^>]*>'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${notification.title ?? ''} - ${notification.data?.companyName ?? ''}',
                    style: GoogleFonts.tajawal(
                      color: const Color(0xFF212121),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                if (notification.readAt == null)
                  CircleAvatar(radius: 4.r, backgroundColor: AppColors.primary),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              _cleanBody(notification.body ?? ''),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.tajawal(
                color: const Color(0xFF757575),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 8.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                timeAgo,
                style: GoogleFonts.tajawal(
                  color: const Color(0xFF757575),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
