import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:badges/badges.dart' as badges;
import 'package:workspace/features/Home/presentation/widgets/btn_search_home_widget.dart';
import 'package:workspace/features/Home/presentation/widgets/loading_home.dart';
import 'package:workspace/features/all_space/controllers/all_space_controller.dart';
import 'package:workspace/features/all_space/data/models/spaces_data_model.dart';
import 'package:workspace/features/all_space/presentation/widgets/all_item_space_widget.dart';
import 'package:workspace/features/bottom_navigation_bar/controllers/btn_nav_controller.dart';
import 'package:workspace/features/search/presentation/widgets/no_result.dart';
import 'package:workspace/utils/routing.dart';

class AllSpaceView extends GetView<AllSpaceController> {
  const AllSpaceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      body: CustomScrollView(
        slivers: [
          Obx(
            () =>
                controller.profileData.loading.isTrue
                    ? HomeShimmerView().appBar
                    : SliverAppBar(
                      backgroundColor: Colors.white,
                      elevation: 1,
                      automaticallyImplyLeading: false,
                      pinned: true,

                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(color: Colors.white),
                        title: SafeArea(
                          bottom: false,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () => Get.find<BtnNavController>().onItemSelected(2),
                                  child: CircleAvatar(
                                    radius: 25.r,
                                    backgroundColor: Color(0xFFE0E0E0),
                                    backgroundImage: NetworkImage(
                                      controller
                                              .profileData
                                              .listProileData
                                              .value
                                              ?.data
                                              ?.user
                                              ?.customer
                                              ?.imageUrl ??
                                          'https://mobile.spaces.areisto.com/themes/Falcon/v3.22.0/assets/img/team/avatar.png',
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: InkWell(
                                    onTap: () => Get.find<BtnNavController>().onItemSelected(2),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        FadeInDown(
                                          duration: Duration(milliseconds: 600),
                                          child: Text(
                                            "مرحبا, ${controller.profileData.listProileData.value?.data?.user?.name ?? 'كزائر'}",
                                            style: GoogleFonts.tajawal(
                                              color: Color(0xFF212121),
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: controller.profileData.listProileData.value != null ? 2.h : 0.h),
                                      controller.profileData.listProileData.value != null ?  FadeInDown(
                                          delay: Duration(milliseconds: 200),
                                          child: Text(
                                            controller
                                                    .profileData
                                                    .listProileData
                                                    .value
                                                    ?.data
                                                    ?.user
                                                    ?.customer
                                                    ?.typeTitle ??
                                                '-',
                                            style: GoogleFonts.tajawal(
                                              color: Color(0xFF616161),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ): SizedBox.shrink(),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => Get.toNamed(AppRouting.notifcationView),
                                  child: Container(
                                    width: 40.w,
                                    height: 40.h,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(width: 1.w, color: Color(0xFFF5F5F5)),
                                    ),
                                    child:
                                    Obx(
                  ()=> badges.Badge(
                    showBadge: controller.fcmController.hasUnread.value,
                    position: badges.BadgePosition.topStart(top: 7, start : 10),
                     badgeStyle: badges.BadgeStyle(
                      padding:  EdgeInsets.all(6.r),
          badgeColor: AppColors.primary, // لون الخلفية

        ),
                    child: Center(child: SvgPicture.asset(AppSvg.notificationSvg))),
                ),

                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
          ),

          SliverPersistentHeader(pinned: true, delegate: MyHeaderDelegate()),

          PagedSliverList<int, Spaces>(
            pagingController: controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate<Spaces>(
              itemBuilder: (context, item, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: AllItemSpaceWidget(
                    id: item.id!,
                    address: item.address ?? '-',
                    available:
                        '${controller.formatTime(item.availableFrom)} - ${controller.formatTime(item.availableTo)}',
                    email: item.email ?? '-',
                    image: item.mainImageUrl ?? '-',
                    mobile: item.mobile ?? '-',
                    nameCompany: item.company?.name ?? '-',
                    ratingAverage: '${item.ratingAverage ?? '0'}',
                    ratingCount: '${item.ratingCount ?? '0'}',
                    typeTitle: item.company?.typeTitle ?? '-',
                  ),
                );
              },
              firstPageProgressIndicatorBuilder:
                  (context) => Column(
                    children: List.generate(
                      4,
                      (_) => Padding(
                        padding: EdgeInsets.only(right: 16.w),
                        child: HomeShimmerView().spaceCard(width: double.infinity),
                      ),
                    ),
                  ),

              newPageProgressIndicatorBuilder:
                  (context) => SpinKitFadingCircle(
                    color: AppColors.primary,
                    size: 50.0,
                    duration: Duration(milliseconds: 1200),
                    controller: controller.animationController,
                  ),
              noItemsFoundIndicatorBuilder: (context) => Center(child: NoResult()),
            ),
          ),
        ],
      ),
    );
  }
}

class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  @override
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      color: AppColors.white,
      child: SizedBox(
        height: maxExtent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),

            // 🎯 BtnSearchHomeWidget يتأثر بالسحب
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: BtnSearchHomeWidget(),
            ),

            SizedBox(height: 12.h),

            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 55.h,
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: Color(0xFFFAFAFA), // fallback for var(--w-1, #FAFAFA)
                        borderRadius: BorderRadius.circular(50.r), // border-radius: 50px
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(3, (index) {
                            return Expanded(
                              child: Obx(
                                () => InkWell(
                                  onTap: () => Get.find<AllSpaceController>().filtersProfit(index),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color:
                                          Get.find<AllSpaceController>().index.value == index
                                              ? AppColors.primary
                                              : Color(0xFFF5F5F5),
                                      borderRadius: BorderRadius.circular(50.r),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      index == 0
                                          ? 'الكل'
                                          : index == 1
                                          ? 'الغير ربحية'
                                          : 'الربحية',
                                      style: GoogleFonts.tajawal(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            Get.find<AllSpaceController>().index.value == index
                                                ? AppColors.white
                                                : AppColors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  InkWell(
                    onTap: () => Get.find<AllSpaceController>().showFilter(context),

                    child: FadeInDown(
                      child: Container(
                        width: 32.w,
                        height: 32.h,
                        // equivalent to padding: 3px;
                        decoration: BoxDecoration(color: Color(0xFF32B599), shape: BoxShape.circle),
                        child: Center(child: SvgPicture.asset(AppSvg.settingSvg)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 150.0.r;

  @override
  double get minExtent => 150.0.r;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
