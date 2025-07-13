import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/features/profile/presentation/widgets/item_profile_widget.dart';
import 'package:workspace/features/visitor_profile/controllers/visitor_profile_controller.dart';
import 'package:workspace/utils/routing.dart';

class VisitorProfileView extends GetView<VisitorProfileController> {
  const VisitorProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            children: [


                   Container(
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
                                      'https://mobile.spaces.areisto.com/themes/Falcon/v3.22.0/assets/img/team/avatar.png',
                                    ), // أو NetworkImage إذا كانت صورة من الإنترنت
                                    fit: BoxFit.cover,
                                    alignment: Alignment(0, -0.1), // يعادل 0px -3.686px تقريبًا
                                  ),
                                  color: Colors.grey[300], // بديل لـ lightgray
                                ),
                              ),
                              title: Text(
                                 'مرحبا بيك , كزائر',
                                textAlign: TextAlign.right,
                                style: GoogleFonts.tajawal(
                                  fontSize: 16.sp, // مع flutter_screenutil
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF212121),
                                ),
                              ),



                            ),
                          ),
                          // child: ...  // تقدر تضيف المحتوى هنا
                        ),
                        SizedBox(height: 16.h,),





              ItemProfileWidget(
                svg: AppSvg.exportSvg,
                iconColor:
                    Color(0xFF000000),

                textColor:

                        Color(0xFF000000),

                text:

                         'تسجيل دخول',
                showIcon: false,
                onTap: () {

                     Get.offAllNamed(AppRouting.signInView);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
