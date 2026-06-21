import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/navigation/app_navigator.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/features/notification/data/model/notification_model.dart';
import 'package:workspace/features/notification/presentation/cubit/notifications_cubit.dart';
import 'package:workspace/features/notification/presentation/widgets/notification_item_widget.dart';

/// إشعار وهمي يُعرض كهيكل عظمي (Skeleton) أثناء التحميل.
final _fakeNotification = Notifications.fromJson({
  'title': 'تم تأكيد الحجز',
  'body': 'تم تأكيد حجزك بنجاح في المساحة المطلوبة خلال الفترة المحددة.',
  'data': {'company_name': 'شركة المساحات اريستو'},
  'created_at': '2026-01-01 09:00:00 am',
});

class NotifcationView extends StatelessWidget {
  const NotifcationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NotificationsCubit>()..loadFirstPage(),
      child: const _NotifcationBody(),
    );
  }
}

class _NotifcationBody extends StatefulWidget {
  const _NotifcationBody();

  @override
  State<_NotifcationBody> createState() => _NotifcationBodyState();
}

class _NotifcationBodyState extends State<_NotifcationBody> {
  final _nav = sl<AppNavigator>();
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
      context.read<NotificationsCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NotificationsCubit>();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          'الاشعارات',
          style: GoogleFonts.tajawal(
            color: const Color(0xFF212121),
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          onPressed: _nav.back,
          icon: Icon(Icons.arrow_back, size: 24.r, color: const Color(0xFF212121)),
        ),
        actions: [
          BlocBuilder<NotificationsCubit, NotificationsState>(
            buildWhen: (p, c) => p.hasUnread != c.hasUnread,
            builder: (context, state) {
              return IconButton(
                onPressed: state.hasUnread ? cubit.markAllAsRead : null,
                icon: SvgPicture.asset(
                  AppSvg.readSvg,
                  colorFilter: ColorFilter.mode(
                    state.hasUnread ? AppColors.primary : const Color(0xFFBDBDBD),
                    BlendMode.srcIn,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state.status == NotificationsStatus.loading ||
              state.status == NotificationsStatus.initial) {
            return Skeletonizer(
              enabled: true,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                itemCount: 5,
                itemBuilder: (context, index) => NotificationItemWidget(
                  notification: _fakeNotification,
                  timeAgo: 'قبل ساعة',
                  onTap: () {},
                ),
              ),
            );
          }
          if (state.items.isEmpty) {
            return RefreshIndicator(
              color: AppColors.primary,
              onRefresh: cubit.loadFirstPage,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(height: 200.h),
                  Center(
                    child: Text('لا توجد إشعارات حاليًا',
                        style: GoogleFonts.tajawal(fontSize: 16.sp)),
                  ),
                ],
              ),
            );
          }
          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: cubit.loadFirstPage,
            child: ListView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              itemCount: state.items.length + 1,
            itemBuilder: (context, index) {
              if (index == state.items.length) {
                return state.loadingMore
                    ? Padding(
                        padding: EdgeInsets.all(16.r),
                        child: const Center(
                          child: SpinKitFadingCircle(color: AppColors.primary, size: 40),
                        ),
                      )
                    : SizedBox(height: 8.h);
              }
              final item = state.items[index];
              return NotificationItemWidget(
                notification: item,
                timeAgo: cubit.timeAgo(item.createdAt ?? ''),
                onTap: () => _nav.offAllToHomeTab(1),
              );
            },
            ),
          );
        },
      ),
    );
  }
}
