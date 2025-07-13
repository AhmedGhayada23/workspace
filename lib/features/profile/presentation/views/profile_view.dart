import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/local_storage.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/features/profile/controllers/profile_controller.dart';
import 'package:workspace/features/profile/presentation/views/loading_profile.dart';
import 'package:workspace/features/profile/presentation/widgets/edit_confirmation_dialog_widget.dart';
import 'package:workspace/features/profile/presentation/widgets/item_profile_widget.dart';
import 'package:workspace/utils/routing.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            children: [
              Obx(
                () =>
                    controller.loading.isTrue
                        ? LoadingProfile().cartProfileLoading
                        : Container(
                          // استخدم .w إذا كنت تستخدم flutter_screenutil
                          height: 82.h, // نفس الشيء
                          decoration: BoxDecoration(
                            color: const Color(0xFFFAFAFA),
                            borderRadius: BorderRadius.circular(6.r), // .r مع screenutil
                          ),
                          child: Center(
                            child: ListTile(
                              leading: Container(
                                width: 58.w,
                                height: 58.h,
                                padding: EdgeInsets.symmetric(vertical: 26.h, horizontal: 27.w),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,

                                  image: DecorationImage(
                                    image: NetworkImage(
                                      controller
                                                  .listProileData
                                                  .value
                                                  ?.data
                                                  ?.user
                                                  ?.customer?.imageUrl !=
                                              null
                                          ? controller
                                              .listProileData
                                              .value!
                                              .data!
                                              .user!
                                              .customer!.imageUrl
                                              .toString()
                                          : 'https://mobile.spaces.areisto.com/themes/Falcon/v3.22.0/assets/img/team/avatar.png',
                                    ), // أو NetworkImage إذا كانت صورة من الإنترنت
                                    fit: BoxFit.cover,
                                    alignment: Alignment(0, -0.1), // يعادل 0px -3.686px تقريبًا
                                  ),
                                  color: Colors.grey[300], // بديل لـ lightgray
                                ),
                              ),
                              title: Text(
                                controller.listProileData.value?.data?.user?.name != null
                                    ? controller.listProileData.value!.data!.user!.name.toString()
                                    : 'مستخدم',
                                textAlign: TextAlign.right,
                                style: GoogleFonts.tajawal(
                                  fontSize: 16.sp, // مع flutter_screenutil
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF212121),
                                ),
                              ),
                              subtitle: Text(
                                controller.listProileData.value?.data?.user?.email != null
                                    ? controller.listProileData.value!.data!.user!.email.toString()
                                    : '',

                                style: GoogleFonts.tajawal(
                                  fontSize: 12.sp, // أو 16.0 بدون screenutil
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF757575),
                                ),
                              ),

                              trailing:
                                   InkWell(
                                        onTap: ()=> Get.toNamed(AppRouting.editProfileView, arguments: controller.listProileData.value?.data?.user?.customer),

                                        child: Container(
                                          width: 40.w,
                                          height: 40.h,

                                          decoration: BoxDecoration(
                                            color: AppColors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          // gap ما له مقابل مباشر داخل Container، لكنه يفيد أكثر داخل Row/Column
                                          child: IconButton(
                                            onPressed:
                                                () =>  Get.toNamed(AppRouting.editProfileView, arguments: controller.listProileData.value?.data?.user?.customer),
                                            icon: SvgPicture.asset(
                                              AppSvg.editSvg,
                                              width: 20.w,
                                              height: 20.h,
                                            ),
                                          ),
                                        ),
                                      )

                            ),
                          ),
                          // child: ...  // تقدر تضيف المحتوى هنا
                        ),
              ),
              SizedBox(height:  32.h),
               ItemProfileWidget(
                    onTap:
                        () => Get.toNamed(
                          AppRouting.settingProfileView,
                          parameters: {
                            'image':
                                controller.listProileData.value?.data?.user?.customer?.imageUrl ?? '',
                            'name': controller.listProileData.value?.data?.user?.name ?? '',
                            'type':
                                controller.listProileData.value?.data?.user?.customer?.type ?? '',
                            'userType':
                                controller.listProileData.value?.data?.user?.customer?.typeTitle ??
                                '',
                            'mobile': controller.listProileData.value?.data?.user?.mobile ?? '',
                            'email': controller.listProileData.value?.data?.user?.email ?? '',
                          },
                        ),
                    svg: AppSvg.setting2Svg,
                    textColor: Color(0xFF212121),
                    boxColor: Color.fromRGBO(214, 240, 235, 0.4),
                    text: 'اعدادات الحساب',
                  ),

              SizedBox(height:  24.h),
               ItemProfileWidget(
                    onTap: () => Get.toNamed(AppRouting.changePasswordView),
                    svg: AppSvg.lockSvg,
                    boxColor: Color.fromRGBO(214, 240, 235, 0.4),
                    textColor: Color(0xFF212121),
                    text: 'كلمة المرور',
                  ),

              SizedBox(height:  24.h),

               ItemProfileWidget(
                    onTap: () {
                      Get.toNamed(AppRouting.deleteAccountSentOtpView);
                    },
                    svg: AppSvg.trashSvg,
                    boxColor: Color.fromRGBO(214, 240, 235, 0.4),
                    textColor: Color(0xFF212121),
                    text: 'حذف الحساب',
                  ),

              SizedBox(height: 24.h),

              ItemProfileWidget(
                svg: AppSvg.exportSvg,
                iconColor:
                    Color(0xFFF75555),

                textColor:

                         Color(0xFFF75555),

                text:

                        'تسجيل الخروج',

                showIcon: false,
                onTap: () {
                   showDialog(
                        context: context,
                        builder:
                            (context) => EditConfirmationDialog(
                              title: 'هل انت متاكد ؟',
                              subTitle: 'هل انت متاكد من تسجيل الخروج ؟',
                              textConfirm: 'تسجيل الخروج',
                              textConfirmColor: Color(0xFFF75555),
                              textCanselColor: Color(0xFF000000),
                              onConfirm: () {
                                controller.logoutAccount();
                              },
                            ),
                      );

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
