import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:workspace/core/navigation/app_navigator.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/features/profile/data/model/profile_data_model.dart';
import 'package:workspace/features/profile/presentation/cubit/profile/profile_cubit.dart';
import 'package:workspace/features/profile/presentation/widgets/edit_confirmation_dialog_widget.dart';
import 'package:workspace/features/profile/presentation/widgets/item_profile_widget.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // الـ ProfileCubit مُوفَّر من BtnNavView (singleton مشترك مع هيدر الرئيسية).
    return const _ProfileBody();
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody();

  void _onState(BuildContext context, ProfileState state) {
    if (state.loggedOut) {
      sl<AppNavigator>().offAllToSignIn();
    } else if (state.errorMessage.isNotEmpty) {
      showCustomSnackBar(context, state.errorMessage, SnackBarType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final nav = sl<AppNavigator>();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: _onState,
            builder: (context, state) {
              final cubit = context.read<ProfileCubit>();
              final loading = state.status != ProfileStatus.loaded;
              final user = state.profile?.data?.user;
              return RefreshIndicator(
                color: AppColors.primary,
                onRefresh: cubit.load,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  Skeletonizer(
                    enabled: loading,
                    child: _profileCard(loading ? null : user, nav),
                  ),
                  SizedBox(height: 32.h),
                  ItemProfileWidget(
                    onTap: nav.toSettingProfile,
                    svg: AppSvg.setting2Svg,
                    textColor: const Color(0xFF212121),
                    boxColor: const Color.fromRGBO(214, 240, 235, 0.4),
                    text: 'اعدادات الحساب',
                  ),
                  SizedBox(height: 24.h),
                  ItemProfileWidget(
                    onTap: nav.toChangePassword,
                    svg: AppSvg.lockSvg,
                    boxColor: const Color.fromRGBO(214, 240, 235, 0.4),
                    textColor: const Color(0xFF212121),
                    text: 'كلمة المرور',
                  ),
                  SizedBox(height: 24.h),
                  ItemProfileWidget(
                    onTap: nav.toDeleteAccount,
                    svg: AppSvg.trashSvg,
                    boxColor: const Color.fromRGBO(214, 240, 235, 0.4),
                    textColor: const Color(0xFF212121),
                    text: 'حذف الحساب',
                  ),
                  SizedBox(height: 24.h),
                  ItemProfileWidget(
                    svg: AppSvg.exportSvg,
                    iconColor: const Color(0xFFF75555),
                    textColor: const Color(0xFFF75555),
                    text: 'تسجيل الخروج',
                    showIcon: false,
                    onTap: () => showDialog(
                      context: context,
                      builder: (_) => EditConfirmationDialog(
                        title: 'هل انت متاكد ؟',
                        subTitle: 'هل انت متاكد من تسجيل الخروج ؟',
                        textConfirm: 'تسجيل الخروج',
                        textConfirmColor: const Color(0xFFF75555),
                        textCanselColor: const Color(0xFF000000),
                        onConfirm: cubit.logout,
                      ),
                    ),
                  ),
                ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _profileCard(User? user, AppNavigator nav) {
    final imageUrl = user?.customer?.imageUrl?.toString() ?? '';
    return Container(
      height: 82.h,
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Center(
        child: ListTile(
          leading: _avatar(imageUrl),
          title: Text(
            user?.name ?? 'مستخدم',
            textAlign: TextAlign.right,
            style: GoogleFonts.tajawal(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF212121),
            ),
          ),
          subtitle: Text(
            user?.email ?? '',
            style: GoogleFonts.tajawal(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF757575),
            ),
          ),
          trailing: InkWell(
            onTap: () => nav.toEditProfile(),
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: const BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
              child: IconButton(
                onPressed: () => nav.toEditProfile(),
                icon: SvgPicture.asset(AppSvg.editSvg, width: 20.w, height: 20.h),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// صورة الحساب: من الرابط إن وُجد، وإلا (أو عند فشل التحميل) أيقونة شخص بديلة.
  Widget _avatar(String url) {
    return Container(
      width: 58.w,
      height: 58.h,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFE3F4F0)),
      child: url.isEmpty
          ? _placeholder()
          : Image.network(
              url,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _placeholder(),
              loadingBuilder: (_, child, progress) => progress == null ? child : _placeholder(),
            ),
    );
  }

  Widget _placeholder() {
    return Padding(
      padding: EdgeInsets.all(14.r),
      child: SvgPicture.asset(
        AppSvg.profileSvg,
        colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
      ),
    );
  }
}
