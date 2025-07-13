import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EditConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final String title;
  final String subTitle;
  final String textConfirm;
  final Color textConfirmColor;
  final Color textCanselColor;


  const EditConfirmationDialog({super.key,
   required this.onConfirm,
   required this.title,
   required this.subTitle,
   this.textConfirmColor = const Color(0xFF246BFD), 
   this.textCanselColor = const Color(0xFFF75555),
   required this.textConfirm,
   });

  @override
  Widget build(BuildContext context) {
    return  Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      backgroundColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // العنوان والنص
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 20.0.h),
            child: Column(
              children: [
               Text(
 title,
  textAlign: TextAlign.center,
  style: GoogleFonts.tajawal(
    color: Color(0xFF212121), // #212121
    fontSize: 18.sp, // حجم الخط 18
    fontWeight: FontWeight.w700, // 700 = Bold
    fontStyle: FontStyle.normal,
    height: 1.0, // line-height: normal => height: 1.0 في Flutter
  ),
),

                SizedBox(height: 8.h),
               Text(
  subTitle,
  textAlign: TextAlign.center,
  style: GoogleFonts.tajawal(
    color: Color(0xFF212121), // اللون #212121
    fontSize: 12.sp, // حجم الخط 12
    fontWeight: FontWeight.w400, // 400 = Regular
    fontStyle: FontStyle.normal,
    height: 1.4, // 140% => 1.4 في Flutter
    letterSpacing: 0.2, // مسافة بين الحروف 0.2px
  ),
),

              ],
            ),
          ),

          Divider(height: 1.h, color: Colors.grey.shade300),

          // الأزرار مع الفاصل
          SizedBox(
            height: 50.h,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      onConfirm();
                      Get.back();
                    },
                    child: Center(
                      child: 
                      Text(
  textConfirm,
  textAlign: TextAlign.center,
  style: GoogleFonts.tajawal(
    color: textConfirmColor, // اللون #246BFD
    fontSize: 18.sp, // حجم الخط 18
    fontWeight: FontWeight.w700, // 700 = Bold
    fontStyle: FontStyle.normal,
    height: 1.0, // line-height: normal => height: 1.0 في Flutter
  ),
),

                    ),
                  ),
                ),
                 Container(
                  width: 1.w,
                  color: Colors.grey.shade300,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => Get.back(),
                    child: Center(
                      child:Text(
  'الغاء',
  textAlign: TextAlign.center,
  style: GoogleFonts.tajawal(
    color: textCanselColor,// اللون الأحمر للتنبيه أو الخطأ
    fontSize: 18.sp, // حجم الخط 18
    fontWeight: FontWeight.w400, // 400 = Regular
    fontStyle: FontStyle.normal,
    height: 1.0, // line-height: normal => 1.0
  ),
),

                    ),
                  ),
                ),
               
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
