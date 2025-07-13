import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shimmer/shimmer.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/local_storage.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/core/widgets/text_field_widget.dart';
import 'package:workspace/features/all_space/data/models/spaces_data_model.dart';
import 'package:workspace/features/search/controllers/search_controller.dart';
import 'package:workspace/features/search/presentation/widgets/no_result.dart';
import 'package:workspace/utils/routing.dart';

class SearchView extends GetView<SearchPageContrller> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                child: Row(
                  children: [
                    InkWell(onTap: () => Get.back(), child: Icon(Icons.arrow_back, size: 24.r)),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Obx(
                        () => TextFieldWidgets(
                          controller: controller.searchTextEditingController,
                          focusNode: controller.focusNode,
                          hint: 'ابحث عن مساحات العمل...',
                          icon: IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              AppSvg.circumSearchSvg,
                              color: Color(0xFFBDBDBD),
                            ),
                          ),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          suffixIcon:
                              controller.searchIsEmpty.isTrue
                                  ? SizedBox.shrink()
                                  : IconButton(
                                    onPressed: () {
                                      controller.searchTextEditingController.clear();
                                      controller.searchIsEmpty.value = true;
                                    },
                                    icon: CircleAvatar(
                                      radius: 14.r,
                                      backgroundColor: const Color(0xFFEEEEEE),
                                      child: const Icon(Icons.close, color: Colors.white),
                                    ),
                                  ),
                          onChanged: (value) {
                            controller.searchIsEmpty.value = value!.trim().isEmpty;
                            return null;
                          },
                          onFieldSubmitted: (value) {
                            controller.getSearchSpace(page: 1,text: value ?? '');
                            controller.searchIsEmpty.value = false;

                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Obx(
                () => SizedBox(
                  height:
                      controller.searchListHistory.isNotEmpty &&
                              controller.listSearchSpacesData.isEmpty &&
                              controller.loading.isFalse
                          ? 24.h
                          : 0,
                ),
              ),
              Obx(
                () =>
                    controller.searchListHistory.isNotEmpty &&
                            controller.listSearchSpacesData.isEmpty &&
                            controller.loading.isFalse
                        ? Text(
                          'البحث الاخير',
                          textAlign: TextAlign.right, // text-align: right
                          style: GoogleFonts.tajawal(
                            color: Color(0xFF212121), // color: var(--b-1, #212121)

                            fontSize: 16.sp, // font-size: 16px
                            fontWeight: FontWeight.w500, // font-weight: 500 (Medium)
                            fontStyle: FontStyle.normal, // font-style: normal
                            height: 1.0, // line-height: normal
                          ),
                        )
                        : SizedBox.shrink(),
              ),
              SizedBox(height: 16.h),

              Obx(
                () =>
                    controller.searchListHistory.isNotEmpty &&
                            controller.listSearchSpacesData.isEmpty &&
                            controller.loading.isFalse
                        ? Wrap(
                          spacing: 8.w, // المسافة بين العناصر في الاتجاه الأفقي
                          runSpacing: 8.h, // المسافة بين العناصر في الاتجاه الرأسي
                          children: List.generate(
                            controller.searchListHistory.length,
                            (index) => InkWell(
                              onTap: () {
                                controller.searchTextEditingController.text =
                                    controller.searchListHistory[index];
                                controller.searchIsEmpty.value = false;
                                controller.getSearchSpace(page: 1,text: controller.searchListHistory[index]);
                              },
                              child: Container(
                                padding: EdgeInsets.all(8.r),
                                decoration: BoxDecoration(
                                  color: Color(0xFFF5F5F5), // background: var(--w-2)
                                  borderRadius: BorderRadius.circular(2.r), // border-radius: 2px
                                ),
                                child: Row(
                                  // display: flex + justify-content + align-items
                                  mainAxisAlignment:
                                      MainAxisAlignment.center, // justify-content: center
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center, // align-items: center
                                  mainAxisSize:
                                      MainAxisSize.min, // يتأكد من أن حجم الـ Row يتناسب مع المحتوى
                                  children: [
                                    InkWell(
                                      onTap: () => controller.clearHistory(index),
                                      child: CircleAvatar(
                                        radius: 8.r,
                                        backgroundColor: Color(0xFFBDBDBD),
                                        child: Center(
                                          child: Icon(Icons.close, color: Colors.white, size: 12.r),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      controller.searchListHistory[index],
                                      textAlign: TextAlign.right, // text-align: right
                                      style: GoogleFonts.tajawal(
                                        color: Color(0xFF212121), // color: var(--B-1, #212121)
                                        fontSize: 14.sp, // font-size: 14px
                                        fontWeight: FontWeight.w700, // font-weight: 700 (Bold)
                                        fontStyle: FontStyle.normal, // font-style: normal
                                        height: 1.0, // line-height: normal
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        : SizedBox.shrink(),
              ),

              Expanded(
                child: Obx(
                  () => controller.loading.isTrue ?
                  Column(
                            children: List.generate(
                              4,
                              (index) => Shimmer.fromColors(
                                baseColor: AppColors.greyText.withOpacity(0.2),
                                highlightColor: AppColors.greyText.withOpacity(0.2),
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 12.h),
                                  height: 35.w,
                                  width: double.infinity,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ) : controller.listSearchSpacesData.isEmpty ? Column(
                            children: [
                            Spacer(),
                            NoResult(),
                            Spacer(),
                            ],
                          ) :
                   ListView.separated(
                    itemBuilder: (context, index) {

                      final item = controller.listSearchSpacesData[index];
                      return InkWell(
                        onTap: () => Get.toNamed(AppRouting.detailsView, arguments: item.id),
                        child: Row(
                          children: [
                            SvgPicture.asset(AppSvg.circumSearchSvg, width: 24.w, height: 24.w),
                            SizedBox(width: 8.w),
                            Text(
                              item.company?.name ?? '',
                              style: GoogleFonts.tajawal(
                                color: const Color(0xFF212121),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                height: 1.3,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              item.province?.name ?? '',
                              style: GoogleFonts.tajawal(
                                color: const Color(0xFF9E9E9E),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: controller.listSearchSpacesData.length,
                  ),
                ),
              ),
              // Expanded(
              //   child: PagedListView<int, Spaces>(
              //     padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              //     pagingController: controller.pagingController,
              //     builderDelegate: PagedChildBuilderDelegate<Spaces>(
              //       itemBuilder: (context, item, index) {
              //         final isLastItem = index == controller.pagingController.itemList!.length - 1;
              //         return Column(
              //           children: [
              //             InkWell(
              //               onTap: () => Get.toNamed(AppRouting.detailsView, arguments: item.id),
              //               child: Row(
              //                 children: [
              //                   SvgPicture.asset(AppSvg.circumSearchSvg, width: 24.w, height: 24.w),
              //                   SizedBox(width: 8.w),
              //                   Text(
              //                     item.company?.name ?? '',
              //                     style: GoogleFonts.tajawal(
              //                       color: const Color(0xFF212121),
              //                       fontSize: 16.sp,
              //                       fontWeight: FontWeight.w500,
              //                       height: 1.3,
              //                     ),
              //                   ),
              //                   SizedBox(width: 4.w),
              //                   Text(
              //                     item.province?.name ?? '',
              //                     style: GoogleFonts.tajawal(
              //                       color: const Color(0xFF9E9E9E),
              //                       fontSize: 14.sp,
              //                       fontWeight: FontWeight.w400,
              //                       height: 1.2,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //             if (!isLastItem) Divider(),
              //           ],
              //         );
              //       },
              //       firstPageProgressIndicatorBuilder: (_) {
              //         if (!controller.loading.value) {
              //           return SizedBox.shrink();
              //         }
              //         return Padding(
              //           padding: EdgeInsets.symmetric(horizontal: 16.w),
              //           child: Column(
              //             children: List.generate(
              //               4,
              //               (index) => Shimmer.fromColors(
              //                 baseColor: AppColors.greyText.withOpacity(0.2),
              //                 highlightColor: AppColors.greyText.withOpacity(0.2),
              //                 child: Container(
              //                   margin: EdgeInsets.only(bottom: 12.h),
              //                   height: 35.w,
              //                   width: double.infinity,
              //                   color: Colors.white,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         );
              //       },
              //       newPageProgressIndicatorBuilder:
              //           (_) => SpinKitFadingCircle(
              //             color: AppColors.primary,
              //             size: 50.0,
              //             duration: Duration(milliseconds: 1200),
              //             controller: controller.animationController,
              //           ),
              //       noItemsFoundIndicatorBuilder: (_) => NoResult(),
              //       firstPageErrorIndicatorBuilder:
              //           (_) => Center(child: Text('فشل في تحميل البيانات')),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
