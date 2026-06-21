import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/navigation/app_navigator.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/features/Home/domain/entities/space_item.dart';
import 'package:workspace/features/Home/presentation/cubit/home_cubit.dart';
import 'package:workspace/features/Home/presentation/widgets/home_header_delegate.dart';
import 'package:workspace/features/Home/presentation/widgets/item_space_widget.dart';
import 'package:workspace/features/all_space/presentation/widgets/all_item_space_widget.dart';
import 'package:workspace/features/search/presentation/widgets/no_result.dart';

const _fakeSpace = SpaceItem(
  id: 0,
  typeTitle: 'مساحة عمل',
  image: '',
  nameCompany: 'شركة المساحات',
  ratingCount: '12',
  ratingAverage: '4.5',
  address: 'غزة - الرمال',
  availableFrom: '09:00 AM',
  availableTo: '05:00 PM',
  email: 'info@example.com',
  mobile: '0591234567',
);

class VisitorHomeView extends StatelessWidget {
  const VisitorHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeCubit>()..load(),
      child: const _VisitorHomeBody(),
    );
  }
}

class _VisitorHomeBody extends StatelessWidget {
  const _VisitorHomeBody();

  @override
  Widget build(BuildContext context) {
    final nav = sl<AppNavigator>();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();
          final loading = state.spacesStatus == HomeStatus.loading ||
              state.spacesStatus == HomeStatus.initial;
          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: cubit.refresh,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                _appBar(),
              SliverPersistentHeader(
                pinned: true,
                delegate: HomeHeaderDelegate(
                  onSearch: nav.toSearch,
                  selectedFilter: state.filterIndex,
                  onFilter: cubit.changeFilter,
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(height: 16.h),
                  _sectionTitle('المساحات الجديدة', onMore: nav.toAllSpace),
                  SizedBox(height: 16.h),
                  _newSpaces(cubit, state, loading, nav),
                  SizedBox(height: 16.h),
                  _sectionTitle('المساحات المقترحة'),
                  SizedBox(height: 16.h),
                  _suggestSpaces(cubit, state, loading, nav),
                  SizedBox(height: 16.h),
                ]),
              ),
            ],
            ),
          );
        },
      ),
    );
  }

  Widget _appBar() {
    return SliverAppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      automaticallyImplyLeading: false,
      pinned: true,
      title: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Container(
                width: 50.r,
                height: 50.r,
                padding: EdgeInsets.all(12.r),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE3F4F0),
                ),
                child: SvgPicture.asset(
                  AppSvg.profileSvg,
                  colorFilter:
                      const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  'مرحبا بيك , كزائر',
                  style: GoogleFonts.tajawal(
                    color: const Color(0xFF212121),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, {VoidCallback? onMore}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.tajawal(
              color: const Color(0xFF212121),
              fontWeight: FontWeight.w500,
              fontSize: 18.sp,
            ),
          ),
          if (onMore != null)
            InkWell(
              onTap: onMore,
              child: Text(
                'مشاهدة المزيد',
                style: GoogleFonts.tajawal(
                  color: const Color(0xFF32B599),
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _newSpaces(HomeCubit cubit, HomeState state, bool loading, AppNavigator nav) {
    if (!loading && state.newSpaces.isEmpty) return const NoResult();
    final items = loading ? List.filled(2, _fakeSpace) : state.newSpaces;
    return Skeletonizer(
      enabled: loading,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: items.map((item) {
            return Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: ItemSpaceWidget(
                id: item.id,
                typeTitle: item.typeTitle,
                image: item.image,
                nameCompany: item.nameCompany,
                ratingCount: item.ratingCount,
                ratingAverage: item.ratingAverage,
                address: item.address,
                available: cubit.availableText(item),
                email: item.email,
                mobile: item.mobile,
                onTap: loading ? null : () => nav.toDetails(item.id),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _suggestSpaces(HomeCubit cubit, HomeState state, bool loading, AppNavigator nav) {
    if (!loading && state.suggestSpaces.isEmpty) return const NoResult();
    final items = loading ? List.filled(2, _fakeSpace) : state.suggestSpaces;
    return Skeletonizer(
      enabled: loading,
      child: Column(
        children: items.map((SpaceItem item) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: AllItemSpaceWidget(
              onTap: loading ? () {} : () => nav.toDetails(item.id),
              id: item.id,
              typeTitle: item.typeTitle,
              image: item.image,
              nameCompany: item.nameCompany,
              ratingCount: item.ratingCount,
              ratingAverage: item.ratingAverage,
              address: item.address,
              available: cubit.availableText(item),
              email: item.email,
              mobile: item.mobile,
            ),
          );
        }).toList(),
      ),
    );
  }
}
