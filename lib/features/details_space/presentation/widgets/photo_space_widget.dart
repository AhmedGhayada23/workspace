import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart'; // Import animate_do

class PhotoSpaceWidget extends StatelessWidget {
 final List<String> image;
  const PhotoSpaceWidget({super.key,required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        image.length,
        (index) =>
        // Applying animation to each photo container
        FadeIn(
          duration: Duration(
            milliseconds: 500 + (index * 100),
          ), // Adjust duration for staggered effect
          child: Container(
            width: double.infinity,
            height: 200.h,
            margin: EdgeInsets.only(bottom: 8.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8.r), // الزوايا المستديرة
              boxShadow: [
                BoxShadow(
                  color: Colors.black12, // لون الظل
                  blurRadius: 6, // مقدار التمويه
                  offset: Offset(0, 1), // موقع الظل (x, y)
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CachedNetworkImage(
                imageUrl: image[index],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                placeholder:
                    (context, url) =>
                        Center(child: Image.asset(AppImage.logoImage, color: AppColors.primary)),
                errorWidget:
                    (context, url, error) =>
                        Center(child: Image.asset(AppImage.logoImage, color: AppColors.primary)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
