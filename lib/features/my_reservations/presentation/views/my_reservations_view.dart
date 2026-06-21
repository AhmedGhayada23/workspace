import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:workspace/core/navigation/app_navigator.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/features/my_reservations/data/models/order_model.dart';
import 'package:workspace/features/my_reservations/presentation/cubit/my_reservations/my_reservations_cubit.dart';
import 'package:workspace/features/my_reservations/presentation/widgets/card_my_resevation_widget.dart';
import 'package:workspace/features/my_reservations/presentation/widgets/items_widget.dart';

const _reservationTabs = ['الكل', 'قيد المراجعة', 'المقبولة', 'المرفوضة'];

/// حجز وهمي يُعرض كهيكل عظمي أثناء التحميل.
final _fakeReservation = Reservations.fromJson({
  'id': 0,
  'start_date': '2026-01-01',
  'created_at': '2026-01-01',
  'status': {'id': 2},
  'space': {'id': 0, 'address': 'غزة - شارع الجلاء', 'main_image_url': ''},
  'company': {'company_name': 'شركة المساحات اريستو'},
});

class MyReservationsView extends StatelessWidget {
  const MyReservationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MyReservationsCubit>()..loadFirstPage(),
      child: const _MyReservationsBody(),
    );
  }
}

class _MyReservationsBody extends StatefulWidget {
  const _MyReservationsBody();

  @override
  State<_MyReservationsBody> createState() => _MyReservationsBodyState();
}

class _MyReservationsBodyState extends State<_MyReservationsBody>
    with SingleTickerProviderStateMixin {
  final _nav = sl<AppNavigator>();
  late final TabController _tabController;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _reservationTabs.length, vsync: this);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      context.read<MyReservationsCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MyReservationsCubit>();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'حجوزاتي',
          style: GoogleFonts.tajawal(
            color: const Color(0xFF212121),
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          onTap: cubit.changeStatus,
          labelColor: AppColors.primary,
          unselectedLabelColor: const Color(0xFF616161),
          indicatorColor: AppColors.primary,
          indicatorWeight: 1,
          dividerColor: const Color(0xFFF5F5F5),
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: GoogleFonts.tajawal(fontSize: 16.sp, fontWeight: FontWeight.w500),
          unselectedLabelStyle: GoogleFonts.tajawal(fontSize: 14.sp, fontWeight: FontWeight.w500),
          tabs: _reservationTabs.map((t) => Text(t)).toList(),
        ),
      ),
      body: BlocConsumer<MyReservationsCubit, MyReservationsState>(
        listenWhen: (p, c) => c.action.hasValue && p.action != c.action,
        listener: (context, state) {
          showCustomSnackBar(
            context,
            state.action.message,
            state.action.isError ? SnackBarType.error : SnackBarType.success,
          );
          context.read<MyReservationsCubit>().clearAction();
        },
        builder: (context, state) {
          if (state.status == ReservationsStatus.loading ||
              state.status == ReservationsStatus.initial) {
            return Skeletonizer(
              enabled: true,
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (_, __) => Padding(
                  padding: EdgeInsets.all(16.r),
                  child: CardMyResevationWidget(
                    reservations: _fakeReservation,
                    show: false,
                    onTap: () {},
                    onCancel: () {},
                    onReReserve: () {},
                  ),
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
                  SizedBox(height: 120.h),
                  const Center(child: NoItemsWidget()),
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
              return Padding(
                padding: EdgeInsets.all(16.r),
                child: CardMyResevationWidget(
                  reservations: item,
                  show: true,
                  onTap: () => _nav.toReservationDetails(item),
                  onCancel: () => cubit.cancel(item.id!),
                  onReReserve: () => cubit.reReserve(item.id!),
                ),
              );
            },
            ),
          );
        },
      ),
    );
  }
}
