import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/local_storage.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/navigation/app_navigator.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/features/Home/domain/entities/home_profile.dart';
import 'package:workspace/features/Home/domain/entities/space_item.dart';
import 'package:workspace/features/Home/presentation/widgets/home_app_bar.dart';
import 'package:workspace/features/all_space/presentation/cubit/all_space_cubit.dart';
import 'package:workspace/features/all_space/presentation/widgets/all_space_header_delegate.dart';
import 'package:workspace/features/all_space/presentation/widgets/province_filter_sheet.dart';
import 'package:workspace/features/all_space/presentation/widgets/all_item_space_widget.dart';
import 'package:workspace/features/notification/presentation/cubit/notification_badge_cubit.dart';
import 'package:workspace/features/profile/presentation/cubit/profile/profile_cubit.dart';
import 'package:workspace/features/search/presentation/widgets/no_result.dart';

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

class AllSpaceView extends StatelessWidget {
  const AllSpaceView({super.key});

  @override
  Widget build(BuildContext context) {
    // الزائر لا حساب له → لا نطلب /profile/me.
    final isVisitor =
        sl<LocalStorage>().readValue<String>(Constants.userType) == 'visitor';
    final profileCubit = sl<ProfileCubit>();
    if (!isVisitor) profileCubit.loadIfNeeded();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AllSpaceCubit>()..init()),
        BlocProvider.value(value: profileCubit),
        // عدّاد الإشعارات المشترك (نفسه في الرئيسية).
        BlocProvider.value(value: sl<NotificationBadgeCubit>()),
      ],
      child: _AllSpaceBody(isVisitor: isVisitor),
    );
  }
}

class _AllSpaceBody extends StatefulWidget {
  final bool isVisitor;

  const _AllSpaceBody({required this.isVisitor});

  @override
  State<_AllSpaceBody> createState() => _AllSpaceBodyState();
}

class _AllSpaceBodyState extends State<_AllSpaceBody> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      context.read<AllSpaceCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final nav = sl<AppNavigator>();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<AllSpaceCubit, AllSpaceState>(
        builder: (context, state) {
          final cubit = context.read<AllSpaceCubit>();
          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () => Future.wait([
              cubit.loadFirstPage(),
              if (!widget.isVisitor) sl<ProfileCubit>().load(),
            ]),
            child: CustomScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
              // الهيدر: للزائر بيانات ثابتة (بلا طلب)، وللعادي من ProfileCubit المشترك.
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, pState) {
                  final profileLoading =
                      !widget.isVisitor && pState.status != ProfileStatus.loaded;
                  final user = pState.profile?.data?.user;
                  return BlocBuilder<NotificationBadgeCubit, int>(
                    builder: (context, unread) {
                      return Skeletonizer.sliver(
                        enabled: profileLoading,
                        child: HomeAppBar(
                          profile: widget.isVisitor
                              ? const HomeProfile(
                                  name: 'مرحبا بيك , كزائر', typeTitle: '', imageUrl: '')
                              : profileLoading
                                  ? _fakeProfile
                                  : HomeProfile(
                                      name: user?.name ?? 'مستخدم',
                                      typeTitle: user?.customer?.typeTitle ?? '-',
                                      imageUrl: user?.customer?.imageUrl ?? '',
                                    ),
                          hasUnread: unread > 0,
                          unreadCount: unread,
                          showNotifications: !widget.isVisitor,
                          onProfileTap: () => nav.offAllToHomeTab(2),
                          onNotificationsTap: nav.toNotifications,
                        ),
                      );
                    },
                  );
                },
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: AllSpaceHeaderDelegate(
                  onSearch: nav.toSearch,
                  selectedFilter: state.profitIndex,
                  onFilter: cubit.changeProfit,
                  onOpenProvince: () => showProvinceFilterSheet(
                    context,
                    provinces: AllSpaceCubit.provinces,
                    currentId: state.provinceId,
                    onApply: cubit.applyProvince,
                  ),
                ),
              ),
              _buildSpaces(context, state, cubit, nav),
            ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSpaces(
    BuildContext context,
    AllSpaceState state,
    AllSpaceCubit cubit,
    AppNavigator nav,
  ) {
    // التحميل الأول → سكليتون مضمون الظهور
    if (state.spacesStatus == AllSpaceStatus.loading ||
        state.spacesStatus == AllSpaceStatus.initial) {
      return Skeletonizer.sliver(
        enabled: true,
        child: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: AllItemSpaceWidget(
                id: _fakeSpace.id,
                typeTitle: _fakeSpace.typeTitle,
                image: _fakeSpace.image,
                nameCompany: _fakeSpace.nameCompany,
                ratingCount: _fakeSpace.ratingCount,
                ratingAverage: _fakeSpace.ratingAverage,
                address: _fakeSpace.address,
                available: '09:00 صباحًا - 05:00 مساءً',
                email: _fakeSpace.email,
                mobile: _fakeSpace.mobile,
                onTap: () {},
              ),
            ),
            childCount: 5,
          ),
        ),
      );
    }

    if (state.spaces.isEmpty) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(child: NoResult()),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == state.spaces.length) {
            return state.loadingMore
                ? Padding(
                    padding: EdgeInsets.all(16.r),
                    child: const Center(
                      child: SpinKitFadingCircle(color: AppColors.primary, size: 40),
                    ),
                  )
                : SizedBox(height: 8.h);
          }
          final item = state.spaces[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: AllItemSpaceWidget(
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
              onTap: () => nav.toDetails(item.id),
            ),
          );
        },
        childCount: state.spaces.length + 1,
      ),
    );
  }
}
