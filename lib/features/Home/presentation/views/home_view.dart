import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/navigation/app_navigator.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/features/Home/domain/entities/home_profile.dart';
import 'package:workspace/features/Home/domain/entities/space_item.dart';
import 'package:workspace/features/Home/presentation/cubit/home_cubit.dart';
import 'package:workspace/features/Home/presentation/widgets/home_app_bar.dart';
import 'package:workspace/features/Home/presentation/widgets/home_header_delegate.dart';
import 'package:workspace/features/Home/presentation/widgets/item_space_widget.dart';
import 'package:workspace/features/all_space/presentation/widgets/all_item_space_widget.dart';
import 'package:workspace/features/bottom_navigation_bar/presentation/cubit/btn_nav_cubit.dart';
import 'package:workspace/features/notification/presentation/cubit/notification_badge_cubit.dart';
import 'package:workspace/features/profile/presentation/cubit/profile/profile_cubit.dart';
import 'package:workspace/features/search/presentation/widgets/no_result.dart';

/// بيانات وهمية تُعرض كهيكل عظمي (Skeleton) أثناء التحميل.
const _fakeProfile = HomeProfile(name: 'محمد عبد الله', typeTitle: 'طالب', imageUrl: '');
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

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeCubit>()..load(),
      child: const _HomeBody(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    final nav = sl<AppNavigator>();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();
          final spacesLoading = state.spacesStatus == HomeStatus.loading ||
              state.spacesStatus == HomeStatus.initial;
          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () => Future.wait([cubit.refresh(), sl<ProfileCubit>().load()]),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
              // الهيدر يقرأ من ProfileCubit المشترك (يتحدّث بعد تعديل البروفايل).
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, pState) {
                  final profileLoading = pState.status != ProfileStatus.loaded;
                  final user = pState.profile?.data?.user;
                  return BlocBuilder<NotificationBadgeCubit, int>(
                    builder: (context, unread) {
                      return Skeletonizer.sliver(
                        enabled: profileLoading,
                        child: HomeAppBar(
                          profile: profileLoading
                              ? _fakeProfile
                              : HomeProfile(
                                  name: user?.name ?? 'مستخدم',
                                  typeTitle: user?.customer?.typeTitle ?? '-',
                                  imageUrl: user?.customer?.imageUrl ?? '',
                                ),
                          hasUnread: unread > 0,
                          unreadCount: unread,
                          onProfileTap: () => context.read<BtnNavCubit>().changeIndex(2),
                          onNotificationsTap: nav.toNotifications,
                        ),
                      );
                    },
                  );
                },
              ),
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
                  _newSpaces(cubit, state, spacesLoading, nav),
                  SizedBox(height: 16.h),
                  _sectionTitle('المساحات المقترحة'),
                  SizedBox(height: 16.h),
                  _suggestSpaces(cubit, state, spacesLoading, nav),
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
