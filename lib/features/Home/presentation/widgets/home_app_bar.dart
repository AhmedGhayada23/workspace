import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/features/Home/domain/entities/home_profile.dart';

class HomeAppBar extends StatelessWidget {
  final HomeProfile? profile;
  final bool hasUnread;
  final VoidCallback onProfileTap;
  final VoidCallback onNotificationsTap;

  /// عدد الإشعارات غير المقروءة (يظهر كرقم على الأيقونة).
  final int unreadCount;

  /// إخفاء أيقونة الإشعارات (مثلاً للزائر الذي لا حساب له).
  final bool showNotifications;

  const HomeAppBar({
    super.key,
    required this.profile,
    required this.hasUnread,
    required this.onProfileTap,
    required this.onNotificationsTap,
    this.unreadCount = 0,
    this.showNotifications = true,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      automaticallyImplyLeading: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(color: Colors.white),
        title: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                InkWell(
                  onTap: onProfileTap,
                  child: _avatar(),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: InkWell(
                    onTap: onProfileTap,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مرحبا, ${profile?.name ?? 'مستخدم'}',
                          style: GoogleFonts.tajawal(
                            color: const Color(0xFF212121),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          profile?.typeTitle ?? '-',
                          style: GoogleFonts.tajawal(
                            color: const Color(0xFF616161),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (showNotifications)
                  InkWell(
                    onTap: onNotificationsTap,
                    child: Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 1.w, color: const Color(0xFFF5F5F5)),
                      ),
                      child: badges.Badge(
                        showBadge: unreadCount > 0 || hasUnread,
                        position: badges.BadgePosition.topEnd(top: 0, end: 2),
                        badgeStyle: badges.BadgeStyle(
                          padding: EdgeInsets.all(unreadCount > 0 ? 5.r : 6.r),
                          badgeColor: AppColors.primary,
                        ),
                        badgeContent: unreadCount > 0
                            ? Text(
                                unreadCount > 99 ? '99+' : '$unreadCount',
                                style: GoogleFonts.tajawal(
                                  color: Colors.white,
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            : null,
                        child: Center(child: SvgPicture.asset(AppSvg.notificationSvg)),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// صورة البروفايل: تستخدم رابط الصورة إن وُجد، وإلا (أو عند فشل التحميل)
  /// تعرض أيقونة شخص بديلة بلون متناسق مع التصميم.
  Widget _avatar() {
    final url = profile?.imageUrl ?? '';
    return Container(
      width: 50.r,
      height: 50.r,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFE3F4F0),
      ),
      child: url.isEmpty
          ? _placeholder()
          : Image.network(
              url,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _placeholder(),
              loadingBuilder: (_, child, progress) =>
                  progress == null ? child : _placeholder(),
            ),
    );
  }

  Widget _placeholder() {
    return Padding(
      padding: EdgeInsets.all(12.r),
      child: SvgPicture.asset(
        AppSvg.profileSvg,
        colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
      ),
    );
  }
}
