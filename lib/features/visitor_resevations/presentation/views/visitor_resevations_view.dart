import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/features/visitor_resevations/controllers/visitor_resevations_controller.dart';
import 'package:workspace/utils/routing.dart';

class VisitorResevationsView extends GetView<VisitorResevationsController> {
  const VisitorResevationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VisitorResevationsController());
    return Scaffold(
      backgroundColor: AppColors.white,

      body: DefaultTabController(
        length: controller.tabs.length,
        child: NestedScrollView(
          headerSliverBuilder:
              (context, innerBoxScrolled) => [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  elevation: 1,
                  automaticallyImplyLeading: false,
                  pinned: true,
                  title: Center(
                    child: FadeInDown(
                      delay: Duration(milliseconds: 1000),
                      child: Text(
                        'حجوزاتي',
                        style: GoogleFonts.tajawal(
                          color: const Color(0xFF212121),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  bottom: TabBar(
                    onTap: (index) {},

                    indicatorPadding: EdgeInsets.symmetric(horizontal: 1.w),
                    padding: EdgeInsets.symmetric(horizontal: 1.w),
                    labelPadding: EdgeInsets.symmetric(horizontal: 1.w),
                    labelColor: AppColors.primary,
                    unselectedLabelColor: const Color(0xFF616161),
                    indicatorColor: AppColors.primary,
                    indicatorWeight: 1,
                    dividerColor: Color(0xFFF5F5F5),
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle: GoogleFonts.tajawal(fontSize: 16.sp, fontWeight: FontWeight.w500),
                    unselectedLabelStyle: GoogleFonts.tajawal(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    tabs: controller.tabs.map((t) => Text(t)).toList(),
                  ),
                ),
              ],
          body: TabBarView(
            children: List.generate(controller.tabs.length, (index) {
              return CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Container(
                 margin: EdgeInsets.all(16.r),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
            color: Colors.white,

            border: Border.all(
              color:  Colors.grey.shade200,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: .3,
                blurRadius: 2,
                blurStyle: BlurStyle.inner,
              ),
            ]
                  ),
                  child:  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

            SizedBox(
                  width: 148.w,
                  height: 148.h,
                  child: Stack(
                    children: [
            Center(
              child: Container(
                width: 148.w,
                height: 148.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.grey.shade200,
                        Colors.white,
                      ]
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Center(
              child: Container(
                width: 116.w,
                height: 116.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade200,),
                ),
              ),
            ),
            Center(
              child:  SvgPicture.asset(
                'assets/svg/document-text.svg',
                width: 62.w,
                height: 62.h,
              ),
            ),
                    ],
                  ),
                ),

            SizedBox(height: 16.h),
            Text(
              'لم يتم تسجيل الدخول',
              style: GoogleFonts.tajawal(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16.h,),
            Text(
              'يرجى تسجيل الدخول أو إنشاء حساب \nفي حالة الرغبة في تقديم حجز مساحة',
              textAlign: TextAlign.center,
              style:  GoogleFonts.tajawal(
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 32.h,),
            SizedBox(
              width: 200.w,
              child: InkWell(
                  onTap: ()=> Get.offAllNamed(AppRouting.signInView),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Container(
                    height: 40.h,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    decoration: BoxDecoration(
            color: AppColors.primary ,
            borderRadius: BorderRadius.circular(360.r),
            border: Border.all(color: Colors.transparent),
                    ),
                    child: Text(
            'تسجيل دخول',
            textAlign: TextAlign.center,
            style:  GoogleFonts.tajawal(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
                    ),
                  ),
                ),
            ),
                    ],
                  ),
                ),
          ),


      ],
    );
            }),
          ),
        ),
      ),
    );
  }
}
