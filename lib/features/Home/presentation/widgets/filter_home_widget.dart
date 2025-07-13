import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/features/Home/controllers/home_controller.dart';
import 'package:workspace/features/visitor_home/controllers/visitor_home_controller.dart';

class FilterNormalHomeWidget extends StatelessWidget {

  const FilterNormalHomeWidget({

    super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
  height: 55.h,
  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
  decoration: BoxDecoration(
    color: const Color(0xFFFAFAFA),
    borderRadius: BorderRadius.circular(50.r),
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: List.generate(3, (index) {
      return Expanded(
        child: Obx(

          ()=> InkWell(
            onTap: ()=>  Get.find<HomeController>().filtersProfit(index),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              height: double.infinity,
                              decoration:  BoxDecoration(
                                  color: Get.find<HomeController>().index.value == index ? AppColors.primary :  Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(50.r),
                              ),
              alignment: Alignment.center,
              child:
                                        Text(
                                    index == 0 ?  'الكل' : index == 1 ? 'الغير ربحية' : 'الربحية',
                                    style: GoogleFonts.tajawal(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Get.find<HomeController>().index.value == index ? AppColors.white : AppColors.black
                                      ),
                                      ),
            ),
          ),
        ),
      );
    }),
  ),
              );
  }
}

class FilterVisitorHomeWidget extends StatelessWidget {

  const FilterVisitorHomeWidget({

    super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
  height: 55.h,
  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
  decoration: BoxDecoration(
    color: const Color(0xFFFAFAFA),
    borderRadius: BorderRadius.circular(50.r),
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: List.generate(3, (index) {
      return Expanded(
        child: Obx(

          ()=> InkWell(
            onTap: ()=>  Get.find<VisitorHomeController>().filtersProfit(index),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              height: double.infinity,
                              decoration:  BoxDecoration(
                                  color: Get.find<VisitorHomeController>().index.value == index ? AppColors.primary :  Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(50.r),
                              ),
              alignment: Alignment.center,
              child:
                                        Text(
                                    index == 0 ?  'الكل' : index == 1 ? 'الغير ربحية' : 'الربحية',
                                    style: GoogleFonts.tajawal(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Get.find<VisitorHomeController>().index.value == index ? AppColors.white : AppColors.black
                                      ),
                                      ),
            ),
          ),
        ),
      );
    }),
  ),
              );
  }
}
