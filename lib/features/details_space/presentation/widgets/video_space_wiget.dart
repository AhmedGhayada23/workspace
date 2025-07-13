import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:workspace/core/styles/app_colors.dart';

class VideoSpaceWidget extends StatelessWidget {
  const VideoSpaceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromRGBO(250, 250, 250, 1),
      highlightColor: const Color.fromRGBO(250, 250, 250, 0.5),
      child: Container(
                    width: double.infinity,
                    height: 167.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.white,

                    ),
      ),
    );
  }
}
