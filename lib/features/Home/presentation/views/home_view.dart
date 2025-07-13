import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/local_storage.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:badges/badges.dart' as badges;
import 'package:workspace/features/Home/controllers/home_controller.dart';
import 'package:workspace/features/Home/presentation/widgets/btn_search_home_widget.dart';
import 'package:workspace/features/Home/presentation/widgets/filter_home_widget.dart';
import 'package:workspace/features/Home/presentation/widgets/item_space_widget.dart';
import 'package:workspace/features/Home/presentation/widgets/loading_home.dart';
import 'package:workspace/features/all_space/presentation/widgets/all_item_space_widget.dart';
import 'package:workspace/features/bottom_navigation_bar/controllers/btn_nav_controller.dart';
import 'package:workspace/features/notification/controllers/fcm_notification_controller.dart';
import 'package:workspace/features/search/presentation/widgets/no_result.dart';
import 'package:workspace/utils/routing.dart';

class HomeView extends GetView<HomeController> {

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
   final controller = Get.put(HomeController());
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
  slivers: [
    Obx(
      ()=> controller.profileData.loading.isTrue ? HomeShimmerView().appBar :
      SliverAppBar(
  backgroundColor: Colors.white,
  elevation: 1,
  automaticallyImplyLeading: false,
  pinned: true,

  flexibleSpace: FlexibleSpaceBar(
    background: Container(
      color: Colors.white,
    ),
    title: SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            InkWell(
              onTap: () => Get.find<BtnNavController>().onItemSelected(2),
              child:  CircleAvatar(
                radius: 25.r,
                backgroundColor: Color(0xFFE0E0E0),
                backgroundImage: NetworkImage(controller.profileData.listProileData.value?.data?.user?.customer?.imageUrl ??'https://mobile.spaces.areisto.com/themes/Falcon/v3.22.0/assets/img/team/avatar.png'),

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
                        "مرحبا, ${controller.profileData.listProileData.value?.data?.user?.name ?? 'مستخدم'}",
                        style: GoogleFonts.tajawal(
                          color: Color(0xFF212121),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    FadeInDown(
                      delay: Duration(milliseconds: 200),
                      child: Text(
                        controller.profileData.listProileData.value?.data?.user?.customer?.typeTitle  ?? '-',
                        style: GoogleFonts.tajawal(
                          color: Color(0xFF616161),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
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
                child: Obx(
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


      SliverPersistentHeader(
        pinned: true,
        delegate: MyHeaderDelegate(),
      ),


   SliverList(
  delegate: SliverChildListDelegate([
    SizedBox(height: 16.h),
  Obx(
      ()=> controller.loading.isTrue ? HomeShimmerView().sectionHeader :
       FadeInLeft(
        child: Padding(
          padding: EdgeInsets.only(left: 16.w,right: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'المساحات الجديدة',
                style: GoogleFonts.tajawal(
                  color: Color(0xFF212121),
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                ),
              ),
              InkWell(
                onTap: () => Get.toNamed(AppRouting.allSpaceView),
                child: Text(
                  'مشاهدة المزيد',
                  style: GoogleFonts.tajawal(
                    color: Color(0xFF32B599),
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    SizedBox(height: 16.h),

    // إضافة SingleChildScrollView للمحتوى
    Obx(
      ()=> controller.loading.isTrue ?

      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(2, (index) => FadeInUp(child: Padding(

            padding:  EdgeInsets.only(right: 16.w),
            child: HomeShimmerView().spaceCard(),
          ))),
        ),
      ):controller.listNewSpacesData.isNotEmpty ?
       SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(controller.listNewSpacesData.length, (index) => FadeInUp(child: Padding(

            padding:  EdgeInsets.only(right: 16.w),
            child: ItemSpaceWidget(
              id: controller.listNewSpacesData[index].id!,
              typeTitle: controller.listNewSpacesData[index].company?.typeTitle ?? '-',
              image: controller.listNewSpacesData[index].mainImageUrl ?? '',
              nameCompany: controller.listNewSpacesData[index].company?.name ?? '-',
              ratingCount:  '${controller.listNewSpacesData[index].ratingCount ?? '0'}',
              ratingAverage: '${controller.listNewSpacesData[index].ratingAverage ?? '0'}',
              address: controller.listNewSpacesData[index].address ?? '-',
              available: '${controller.formatTime(controller.listNewSpacesData[index].availableFrom)} - ${controller.formatTime(controller.listNewSpacesData[index].availableTo)}',

              email: controller.listNewSpacesData[index].email ?? '-',
              mobile: controller.listNewSpacesData[index].mobile ?? '-',


            ),
          ))),
        ),
      ): NoResult(),
    ),

    SizedBox(height: 16.h),

    Obx(
      ()=>controller.loading.isTrue ?
      HomeShimmerView().sectionHeader :
       FadeInLeft(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Text(
                'المساحات المقترحة',
                style: GoogleFonts.tajawal(
                  color: Color(0xFF212121),
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    SizedBox(height: 16.h),

    // إضافة SingleChildScrollView حول محتوى الـColumn


    Obx(
      ()=> controller.loading.isTrue  ?
       SingleChildScrollView(
        child: Column(
          children: List.generate(2, (index) => FadeInUp(child: Padding(
            padding: EdgeInsets.only(left: 16.w,right: 16.w),
            child:  HomeShimmerView().spaceCard(width: double.infinity),
          ))),
        ),
      ):
      controller.listsuggestSpacesData.isNotEmpty ?
       SingleChildScrollView(
        child: Column(
          children: List.generate(controller.listsuggestSpacesData.length, (index) => FadeInUp(child: Padding(
            padding: EdgeInsets.only(left: 16.w,right: 16.w),
            child: AllItemSpaceWidget(
              onTap: ()=> Get.toNamed(AppRouting.detailsView,arguments: controller.listsuggestSpacesData[index].id!),
              id: controller.listsuggestSpacesData[index].id!,
               typeTitle: controller.listsuggestSpacesData[index].company?.typeTitle ?? '-',
              image: controller.listsuggestSpacesData[index].mainImageUrl ?? '',
              nameCompany: controller.listsuggestSpacesData[index].company?.name ?? '-',
              ratingCount:  '${controller.listsuggestSpacesData[index].ratingCount ?? '0'}',
              ratingAverage: '${controller.listsuggestSpacesData[index].ratingAverage ?? '0'}',
              address: controller.listsuggestSpacesData[index].address ?? '-',
              available: '${controller.formatTime(controller.listsuggestSpacesData[index].availableFrom)} - ${controller.formatTime(controller.listsuggestSpacesData[index].availableTo)}',
              email: controller.listsuggestSpacesData[index].email ?? '-',
              mobile: controller.listsuggestSpacesData[index].mobile ?? '-',
            ),
          ))),
        ),
      ): NoResult(),
    ),
  ]),
)


  ],
),



    );
  }


}
class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override@override
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
            padding: EdgeInsets.only(left: 16.w,right: 16.w),
            child: BtnSearchHomeWidget(),
          ),

          SizedBox(height: 12.h),

          // 🔒 ثابت لا يتأثر بالسحب
          Padding(
            padding: EdgeInsets.only(left: 16.w,right: 16),
            child: FilterNormalHomeWidget(),
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
