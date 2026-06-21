import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/features/details_space/data/model/details_space_model.dart';
import 'package:workspace/features/details_space/presentation/widgets/description_widget.dart';
import 'package:workspace/features/details_space/presentation/widgets/photo_space_widget.dart';
import 'package:workspace/features/details_space/presentation/widgets/reviews_widget.dart';
import 'package:workspace/features/details_space/presentation/widgets/subscriotion_widget.dart';
import 'package:workspace/features/search/presentation/widgets/no_result.dart';

const detailsTabs = ['التفاصيل', 'الصور', 'الاشتراكات', 'التقييمات'];

class DetailsTabBar extends StatelessWidget {
  final TabController controller;

  const DetailsTabBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorPadding: EdgeInsets.symmetric(horizontal: 1.w),
      padding: EdgeInsets.symmetric(horizontal: 1.w),
      labelPadding: EdgeInsets.symmetric(horizontal: 1.w),
      controller: controller,
      labelColor: AppColors.primary,
      unselectedLabelColor: const Color(0xFF616161),
      indicatorColor: AppColors.primary,
      indicatorWeight: 1.w,
      dividerColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: GoogleFonts.tajawal(fontSize: 16.sp, fontWeight: FontWeight.w500),
      unselectedLabelStyle: GoogleFonts.tajawal(fontSize: 14.sp, fontWeight: FontWeight.w500),
      tabs: detailsTabs.map((t) => Text(t)).toList(),
    );
  }
}

/// محتوى التبويب المختار (تفاصيل / صور / اشتراكات / تقييمات).
class DetailsTabContent extends StatelessWidget {
  final Data? data;
  final int tabIndex;

  const DetailsTabContent({super.key, required this.data, required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    final space = data?.spaces;
    switch (tabIndex) {
      case 0:
        return (space?.content?.isNotEmpty ?? false)
            ? DescriptionWidget(
                text: space?.content ?? '',
                suggestSpaces: data?.suggestSpaces ?? [],
              )
            : const NoResult();
      case 1:
        return (space?.imagesUrl?.isNotEmpty ?? false)
            ? PhotoSpaceWidget(image: space?.imagesUrl ?? [])
            : const NoResult(text: 'هذه المساحة لا تحتوي على صور مرفقة في الوقت الحالي');
      case 2:
        return (space?.subscriptions?.isNotEmpty ?? false)
            ? SubscriotionWidget(subscriptions: space!.subscriptions!)
            : const NoResult(text: 'عذرًا، لا تتوفر تفاصيل لهذه المساحة حاليًا');
      case 3:
        return (space?.customerRatingAverages?.isNotEmpty ?? false)
            ? ReviewsWidget(evaluations: space?.customerRatingAverages ?? [])
            : const NoResult(text: 'هذه المساحة لا تحتوي على تقييمات في الوقت الحالي');
      default:
        return const SizedBox.shrink();
    }
  }
}

/// محتوى وهمي لمحتوى التبويب أثناء التحميل — يلفّه [Skeletonizer] في الشاشة فيتحوّل لعظام.
class DetailsTabContentLoading extends StatelessWidget {
  const DetailsTabContentLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < 4; i++)
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Text(
              'هذا نص وهمي يعرض كهيكل عظمي أثناء تحميل تفاصيل المساحة الحالية',
              style: GoogleFonts.tajawal(fontSize: 14.sp),
            ),
          ),
        SizedBox(height: 16.h),
        Container(
          width: double.infinity,
          height: 120.h,
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ],
    );
  }
}
