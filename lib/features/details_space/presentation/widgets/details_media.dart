import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/features/details_space/data/model/details_space_model.dart';

/// وسائط المساحة: فيديو إن وُجد وجاهز، وإلا الصورة الرئيسية.
class DetailsMedia extends StatelessWidget {
  final Spaces? space;
  final ChewieController? chewieController;

  const DetailsMedia({super.key, required this.space, required this.chewieController});

  @override
  Widget build(BuildContext context) {
    final showVideo = space?.videoUrl != null && chewieController != null;
    return Container(
      width: double.infinity,
      height: 167.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const Color(0xFFFAFAFA),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.r),
        child: showVideo
            ? Chewie(controller: chewieController!)
            : CachedNetworkImage(
                imageUrl: space?.mainImageUrl.toString() ?? '',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                placeholder: (context, url) =>
                    Center(child: Image.asset(AppImage.logoImage, color: AppColors.primary)),
                errorWidget: (context, url, error) =>
                    Center(child: Image.asset(AppImage.logoImage, color: AppColors.primary)),
              ),
      ),
    );
  }
}
