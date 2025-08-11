import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/features/Home/presentation/widgets/loading_home.dart';
import 'package:workspace/features/details_space/controllers/details_space_controller.dart';
import 'package:workspace/features/details_space/presentation/widgets/description_widget.dart';
import 'package:workspace/features/details_space/presentation/widgets/information_about_space_widget.dart';
import 'package:workspace/features/details_space/presentation/widgets/lodding_details_space.dart';
import 'package:workspace/features/details_space/presentation/widgets/photo_space_widget.dart';
import 'package:workspace/features/details_space/presentation/widgets/reviews_widget.dart';
import 'package:workspace/features/details_space/presentation/widgets/subscriotion_widget.dart';
import 'package:workspace/features/search/presentation/widgets/no_result.dart';
import 'package:workspace/utils/routing.dart';
import 'package:animate_do/animate_do.dart'; // Import animate_do

class DetailsSpaceView extends GetView<DetailsSpaceController> {
  const DetailsSpaceView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.onInit();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.0,
        leading: IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
        centerTitle: true,
        title: Obx(
          () =>
              controller.loading.isTrue
                  ? SizedBox.shrink()
                  : FadeIn(
                    duration: Duration(milliseconds: 500),
                    child: Text(
                      '${controller.listDetailsSpacesData.value?.data?.spaces?.company?.name} - ${controller.listDetailsSpacesData.value?.data?.spaces?.province?.name}',
                      textAlign: TextAlign.right,
                      style: GoogleFonts.tajawal(
                        color: const Color(0xFF212121),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Opacity(
          opacity: controller.loading.isTrue ? 0.2 : 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFF9FAFB), width: 1.w),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(0, 0, 0, 0.04),
                  offset: const Offset(0, -2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                Center(
                  child: InkWell(
                    onTap: () {
                      if (controller.listDetailsSpacesData.value!.data!.spaces!.company!.type !=
                              'profit' &&
                          controller
                              .listDetailsSpacesData
                              .value!
                              .data!
                              .spaces!
                              .subscriptions!
                              .isNotEmpty) {
                        showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                          ),
                          backgroundColor: const Color(0xFFFAFAFA),
                          isScrollControlled: false,
                          builder: (BuildContext context) {
                            return Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FadeInUp(
                                    child: Text(
                                      'نوع الحجز',
                                      style: GoogleFonts.tajawal(
                                        color: const Color(0xFF616161),
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 24.h),
                                  SizedBox(
                                    height: 75.h, // أو حسب ما يناسبك
                                    child: ListView.builder(
                                      itemCount: 2,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            controller.idTypeBooking.value = index;
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: 16.h),
                                            child: FadeInUp(
                                              child: Row(
                                                children: [
                                                  Obx(
                                                    () => Container(
                                                      width: 24.w,
                                                      height: 24.h,
                                                      padding: EdgeInsets.all(2.r),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          width: 3,
                                                          color:
                                                              controller.idTypeBooking.value ==
                                                                      index
                                                                  ? const Color(0xFF32B599)
                                                                  : const Color(0xFFD6F0EB),
                                                        ),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child:
                                                          controller.idTypeBooking.value == index
                                                              ? Container(
                                                                decoration: const BoxDecoration(
                                                                  color: Color(0xFF32B599),
                                                                  shape: BoxShape.circle,
                                                                ),
                                                              )
                                                              : null,
                                                    ),
                                                  ),
                                                  SizedBox(width: 8.w),
                                                  Text(
                                                    index == 0
                                                        ? 'مدفوع - اشتراكات'
                                                        : 'مجاني - غير ربحي',
                                                    style: GoogleFonts.tajawal(
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w500,
                                                      color: const Color(0xFF000000),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  BounceInDown(
                                    child: InkWell(
                                      onTap: () {
                                        if (controller.idTypeBooking.value == 0) {
                                          Get.toNamed(
                                            AppRouting.bookingView,

                                            arguments: {
                                              'subscriptions':
                                                  controller
                                                      .listDetailsSpacesData
                                                      .value!
                                                      .data!
                                                      .spaces!
                                                      .subscriptions,
                                              'space':
                                                  controller
                                                      .listDetailsSpacesData
                                                      .value!
                                                      .data!
                                                      .spaces,
                                            },
                                            parameters: {
                                              'id':
                                                  controller
                                                      .listDetailsSpacesData
                                                      .value!
                                                      .data!
                                                      .spaces!
                                                      .id
                                                      .toString(),
                                              'is_profit': 'true',
                                            },
                                          );
                                        } else {
                                          Get.back();
                                          controller.confirmBookingNonProfit(
                                            controller
                                                .listDetailsSpacesData
                                                .value!
                                                .data!
                                                .spaces!
                                                .id!,
                                          );
                                        }
                                      },
                                      child: Container(
                                        height: 44.h,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10.h,
                                          horizontal: 16.w,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF32B599),
                                          borderRadius: BorderRadius.circular(50.r),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'احجز الان',
                                              style: GoogleFonts.tajawal(
                                                color: const Color(0xFFFAFAFA),
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500,
                                                height: 1.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else if (controller
                                  .listDetailsSpacesData
                                  .value!
                                  .data!
                                  .spaces!
                                  .company!
                                  .type !=
                              'profit' &&
                          controller
                              .listDetailsSpacesData
                              .value!
                              .data!
                              .spaces!
                              .subscriptions!
                              .isEmpty) {
                        controller.confirmBookingNonProfit(
                          controller.listDetailsSpacesData.value!.data!.spaces!.id!,
                        );
                      } else {
                        Get.toNamed(
                          AppRouting.bookingView,

                          arguments: {
                            'subscriptions':
                                controller.listDetailsSpacesData.value!.data!.spaces!.subscriptions,
                            'space': controller.listDetailsSpacesData.value!.data!.spaces,
                          },
                          parameters: {
                            'id':
                                controller.listDetailsSpacesData.value!.data!.spaces!.id.toString(),
                            'is_profit': 'true',
                          },
                        );
                      }
                      // controller.showTypeBooking.value = true;

                      // controller.listDetailsSpacesData.value!.data!.spaces!.company!.type ==
                      //         'profit'
                      //     ?
                      //     :  controller.confirmBookingNonProfit(controller.listDetailsSpacesData.value!.data!.spaces!.id!);
                    },
                    child: Obx(
                      () =>
                          controller.loadingNonProfit.isTrue
                              ? Center(child: CircularProgressIndicator(color: AppColors.primary))
                              : Container(
                                height: 44.h,
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),

                                decoration: BoxDecoration(
                                  color: const Color(0xFF32B599),
                                  borderRadius: BorderRadius.circular(50.r),
                                ),
                                child: Center(
                                  child: Text(
                                    'احجز الان',
                                    style: GoogleFonts.tajawal(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () =>
                    controller.loading.isTrue
                        ? LoddingDetailsSpace().videoLodding
                        : FadeInUp(
                          duration: Duration(milliseconds: 500),
                          child: Container(
                            width: double.infinity,
                            height: 167.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: const Color(0xFFFAFAFA),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4.r),
                              child:
                                  controller.listDetailsSpacesData.value!.data!.spaces!.videoUrl ==
                                          null
                                      ? CachedNetworkImage(
                                        imageUrl:
                                            controller
                                                .listDetailsSpacesData
                                                .value!
                                                .data!
                                                .spaces!
                                                .mainImageUrl
                                                .toString(),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                        placeholder:
                                            (context, url) => Center(
                                              child: Image.asset(
                                                AppImage.logoImage,
                                                color: AppColors.primary,
                                              ),
                                            ),
                                        errorWidget:
                                            (context, url, error) => Center(
                                              child: Image.asset(
                                                AppImage.logoImage,
                                                color: AppColors.primary,
                                              ),
                                            ),
                                      )
                                      : Chewie(controller: controller.chewieController!),
                            ),
                          ),
                        ),
              ),
              // Information Space
              Obx(
                () =>
                    controller.loading.isTrue
                        ? LoddingDetailsSpace().informationLoading()
                        : InformationAboutSpaceWidget(
                          nameSpace:
                              controller.listDetailsSpacesData.value?.data?.spaces?.company?.name ??
                              '-',
                          typeTitle:
                              controller
                                  .listDetailsSpacesData
                                  .value
                                  ?.data
                                  ?.spaces
                                  ?.company
                                  ?.typeTitle ??
                              '-',
                          ratingCount:
                            '${controller.listDetailsSpacesData.value?.data?.spaces?.customerRatingAverages?.length ?? '0'}',
                          ratingAverage:
                              '${controller.listDetailsSpacesData.value?.data?.spaces?.ratingAverage ?? '0'}',
                          address:
                              controller.listDetailsSpacesData.value?.data?.spaces?.address ?? '-',
                          available:
                              '${controller.formatTime(controller.listDetailsSpacesData.value?.data?.spaces?.availableFrom)} - ${controller.formatTime(controller.listDetailsSpacesData.value?.data?.spaces?.availableTo)}',
                          mobile:
                              controller.listDetailsSpacesData.value?.data?.spaces?.mobile ?? '-',
                          eamil: controller.listDetailsSpacesData.value?.data?.spaces?.email ?? '-',
                          customersCount:
                              '${controller.listDetailsSpacesData.value?.data?.spaces?.customersCount ?? '0'}',
                          nameCompany:
                              controller
                                  .listDetailsSpacesData
                                  .value
                                  ?.data
                                  ?.spaces
                                  ?.company
                                  ?.user
                                  ?.name ??
                              '-',
                          imageCompany:
                              controller
                                  .listDetailsSpacesData
                                  .value
                                  ?.data
                                  ?.spaces
                                  ?.company
                                  ?.imageUrl ??
                              '',
                        ),
              ),
              SizedBox(height: 24.h),
              Obx(
                () =>
                    controller.loading.isTrue
                        ? LoddingDetailsSpace().sectionDetailsSpaceLoading
                        : FadeInUp(
                          duration: Duration(milliseconds: 1500),

                          child: TabBar(
                            indicatorPadding: EdgeInsets.symmetric(horizontal: 1.w),
                            padding: EdgeInsets.symmetric(horizontal: 1.w),
                            labelPadding: EdgeInsets.symmetric(horizontal: 1.w),
                            controller: controller.tabController,
                            labelColor: AppColors.primary,
                            unselectedLabelColor: const Color(0xFF616161),
                            indicatorColor: AppColors.primary,
                            indicatorWeight: 1.w,
                            dividerColor: Colors.transparent,
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelStyle: GoogleFonts.tajawal(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            unselectedLabelStyle: GoogleFonts.tajawal(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            tabs: controller.tabs.map((t) => Text(t)).toList(),
                          ),
                        ),
              ),
              SizedBox(height: 16.h),
              Obx(
                () =>
                    controller.loading.isTrue
                        ? Column(
                          children: [
                            LoddingDetailsSpace().buildTextShimmer(),
                            SizedBox(height: 16.h),
                            HomeShimmerView().spaceCard(width: double.infinity),
                          ],
                        )
                        : GetBuilder<DetailsSpaceController>(
                          builder: (controller) {
                            final currentTab = controller.tabController.index;
                            switch (currentTab) {
                              case 0:
                                return FadeInUp(
                                  duration: Duration(milliseconds: 1600),
                                  child:
                                      controller
                                              .listDetailsSpacesData
                                              .value!
                                              .data!
                                              .spaces!
                                              .content!
                                              .isNotEmpty
                                          ? DescriptionWidget(
                                            text:
                                                controller
                                                    .listDetailsSpacesData
                                                    .value
                                                    ?.data
                                                    ?.spaces
                                                    ?.content ??
                                                '',
                                                suggestSpaces: controller.listDetailsSpacesData.value?.data?.suggestSpaces ?? [],
                                          )
                                          : NoResult(

                                          ),
                                );
                              case 1:
                                return FadeInUp(
                                  duration: Duration(milliseconds: 1700),
                                  child:
                                      controller
                                              .listDetailsSpacesData
                                              .value!
                                              .data!
                                              .spaces!
                                              .imagesUrl!
                                              .isNotEmpty
                                          ? PhotoSpaceWidget(
                                            image:
                                                controller
                                                    .listDetailsSpacesData
                                                    .value
                                                    ?.data
                                                    ?.spaces
                                                    ?.imagesUrl ??
                                                [],
                                          )
                                          : NoResult(
                                            text: 'هذه المساحة لا تحتوي على صور مرفقة في الوقت الحالي',
                                          ),
                                );
                              case 2:
                                return FadeInUp(
                                  duration: Duration(milliseconds: 1800),
                                  child:
                                      controller
                                              .listDetailsSpacesData
                                              .value!
                                              .data!
                                              .spaces!
                                              .subscriptions!
                                              .isNotEmpty
                                          ? SubscriotionWidget(
                                            subscriptions:
                                                controller
                                                    .listDetailsSpacesData
                                                    .value!
                                                    .data!
                                                    .spaces!
                                                    .subscriptions!,
                                          )
                                          : NoResult(
                                            text: 'عذرًا، لا تتوفر تفاصيل لهذه المساحة حاليًا',
                                          ),
                                );
                              case 3:
                                return FadeInUp(
                                  duration: Duration(milliseconds: 1900),
                                  child: controller
                                              .listDetailsSpacesData
                                              .value!
                                              .data!
                                              .spaces!
                                        .customerRatingAverages!.isNotEmpty
                                    ?

                                   ReviewsWidget(evaluations: controller
                                              .listDetailsSpacesData
                                              .value!
                                              .data!
                                              .spaces!
                                              .customerRatingAverages ??
                                            [])
                                    : NoResult(
                                                 text: 'هذه المساحة لا تحتوي على تقييمات في الوقت الحالي',
                                              ),
                                );
                              default:
                                return const SizedBox.shrink();
                            }
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
