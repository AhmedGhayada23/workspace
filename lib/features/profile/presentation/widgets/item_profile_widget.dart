
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_colors.dart';

class ItemProfileWidget extends StatelessWidget {
  final Function()? onTap;
  final String? text,svg;
  final bool showIcon;
  final Color? textColor;
  final Color? boxColor;
  final Color? iconColor;


  const ItemProfileWidget({
    this.onTap,
    this.svg,
    this.text,
    this.showIcon = true,
    this.textColor,
    this.boxColor,
    this.iconColor = AppColors.primary,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
       
        
      
        decoration: BoxDecoration(
          color: Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child:  ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                
          
          leading: Container(
          width: 32.w,
          height: 32.h,
         
           decoration: BoxDecoration(
          color: boxColor,
          shape: BoxShape.circle
           ),
          // gap ما له مقابل مباشر داخل Container، لكنه يفيد أكثر داخل Row/Column
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: (){}, icon: SvgPicture.asset(svg!,width: 24.w,height: 24.h,color: iconColor),),
        
               
              
        ),
        title: Text(
               text ?? '',
        textAlign: TextAlign.right,
        style: GoogleFonts.tajawal(
              
          fontSize: 16.sp, // أو 16.0 إذا ما تستخدم flutter_screenutil
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
              ),
              
              
        trailing: showIcon != false ?  Icon(Icons.arrow_forward_ios_outlined,size: 16.r,color: Color(0xFF757575),) : null,
        ),
        
      ),
    );
  }
}