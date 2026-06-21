import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workspace/core/localization/app_tr.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/core/theme/text_styles.dart';

class ButtonWithGoogleWidget extends StatelessWidget {
  final Function()? onTap;
  const ButtonWithGoogleWidget({super.key,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap: onTap,
      child: Container(
      height: 48.h,
      decoration: BoxDecoration(
        color : AppColors.white,
        borderRadius: BorderRadius.circular(50.r),
        border: Border.all(width: 1.r,color: Color(0xFFF5F5F5),),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppSvg.googleSvg,width: 24.w,height: 24.h,),
          SizedBox(width: 16.w,),
          Text('continue_with_google'.tr,style: AppTextStyles.body,),
        ],
      ),
        ),
    );
  }
}