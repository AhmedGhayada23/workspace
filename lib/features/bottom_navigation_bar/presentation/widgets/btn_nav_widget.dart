import 'package:animate_do/animate_do.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/features/bottom_navigation_bar/controllers/btn_nav_controller.dart';

class BtnNavWidget extends StatelessWidget {
  final int itemCount;
  final int activeIndex;
  final Function(int) onTap;
  const BtnNavWidget(
      {required this.itemCount,
      required this.activeIndex,
      required this.onTap,
      super.key});
// height: 83.h,
//         padding: EdgeInsets.symmetric(horizontal: 24.w),
//         decoration: BoxDecoration(
//           color: Colors.white, // background: #FFF;
//           border: Border.all(
//             color: Color(0xFFF9FAFB), // fallback for var(--2-5, #F9FAFB)
//             width: 1, // border: 1px solid
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Color.fromRGBO(0, 0, 0, 0.04), // rgba(0, 0, 0, 0.04)
//               offset: Offset(0, -2), // 0px -2px
//               blurRadius: 4, // 4px
//               spreadRadius: 0, // 0px
//             ),
//           ],
  @override
  Widget build(BuildContext context) {
    return 
      ElasticInUp(
         duration : const Duration(milliseconds: 3000),
         child: Container(
           decoration: BoxDecoration(
             color: Colors.white,
             boxShadow: [
               BoxShadow(
          color: const Color.fromRGBO(0, 0, 0, 0.1),
          blurRadius: 10,
          offset: Offset(0, -2), // الظل للأعلى قليلاً
               ),
             ],
           ),
           child: AnimatedBottomNavigationBar.builder(
            backgroundColor : AppColors.white,
           height: 83.h,
            elevation: 1,
            itemCount: itemCount,
            gapLocation: GapLocation.none,
            tabBuilder: (int index, bool isActive) {
              
              return Center(
                child: Container(
                  height: 45.h,
                         margin: EdgeInsets.symmetric(horizontal: 10.w),
                 // padding: EdgeInsets.symmetric(horizontal:isActive ? 24.w : 0.w,),
                  //
                
                  decoration:isActive ? BoxDecoration(
                    color: Color.fromRGBO(214, 240, 235, 0.5),
                    borderRadius: BorderRadius.circular(isActive ? 20.r : 0.r),
                  ):null,
                  child: Row(
                
                   mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                  
                    SvgPicture.asset( Get.find<BtnNavController>().btnData[index].image.toString(),width: 24.w,height: 24.h,color: isActive ? Color(0xFF32B599) : Color(0xFF66707A)  ,),
                  SizedBox(width: 4.w,),
                    Text(
                   Get.find<BtnNavController>().btnData[index].name.toString(),// استبدل بالنص الذي تريده
                    style: GoogleFonts.tajawal(
                      color: isActive ? Color(0xFF32B599) : Color(0xFF66707A),      // اللون من المتغير p-1
                      fontSize: 16.sp,                   // الحجم 16
                      fontWeight: FontWeight.w500,    // Medium
                    
                            
                    ),
                  ),
                  
                    ],
                  ),
                ),
              );
            },
            
            activeIndex: activeIndex,
            leftCornerRadius: 0.r,
            rightCornerRadius: 0.r,
           
            onTap: onTap,
                 
               ),
         ),
       );
  }
}
