import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/local_storage.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/features/Home/presentation/views/home_view.dart';
import 'package:workspace/features/bottom_navigation_bar/presentation/cubit/btn_nav_cubit.dart';
import 'package:workspace/features/bottom_navigation_bar/presentation/widgets/btn_nav_widget.dart';
import 'package:workspace/features/my_reservations/presentation/views/my_reservations_view.dart';
import 'package:workspace/features/notification/presentation/cubit/notification_badge_cubit.dart';
import 'package:workspace/features/profile/presentation/cubit/profile/profile_cubit.dart';
import 'package:workspace/features/profile/presentation/views/profile_view.dart';
import 'package:workspace/features/visitor_home/presentation/views/visitor_home_view.dart';
import 'package:workspace/features/visitor_profile/presentation/views/visitor_profile_view.dart';
import 'package:workspace/features/visitor_resevations/presentation/views/visitor_resevations_view.dart';

class BtnNavView extends StatelessWidget {
  final int initialIndex;

  const BtnNavView({super.key, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    // الزائر ليس له حساب → لا نطلب /profile/me إطلاقاً.
    final isVisitor =
        sl<LocalStorage>().readValue<String>(Constants.userType) == 'visitor';
    final profileCubit = sl<ProfileCubit>();
    if (!isVisitor) profileCubit.loadIfNeeded();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<BtnNavCubit>()..init(initialIndex)),
        // singleton مشترك بين الرئيسية (الهيدر) وتبويب الحساب (للمستخدم العادي فقط).
        BlocProvider.value(value: profileCubit),
        // عدّاد الإشعارات المشترك (الرئيسية + all_space).
        BlocProvider.value(value: sl<NotificationBadgeCubit>()),
      ],
      child: _BtnNavBody(initialIndex: initialIndex, isVisitor: isVisitor),
    );
  }
}

class _BtnNavBody extends StatefulWidget {
  final int initialIndex;
  final bool isVisitor;

  const _BtnNavBody({required this.initialIndex, required this.isVisitor});

  @override
  State<_BtnNavBody> createState() => _BtnNavBodyState();
}

class _BtnNavBodyState extends State<_BtnNavBody> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (!widget.isVisitor) sl<NotificationBadgeCubit>().refresh();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // عند عودة التطبيق للواجهة (مثلاً بعد إشعار في الخلفية) حدّث العدّاد.
    if (state == AppLifecycleState.resumed && !widget.isVisitor) {
      sl<NotificationBadgeCubit>().refresh();
    }
  }

  List<Widget> _pagesFor(UserType type) {
    if (type == UserType.normal) {
      return const [HomeView(), MyReservationsView(), ProfileView()];
    }
    return const [VisitorHomeView(), VisitorResevationsView(), VisitorProfileView()];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BtnNavCubit, BtnNavState>(
      builder: (context, state) {
        final cubit = context.read<BtnNavCubit>();
        final pages = _pagesFor(state.userType);
        return Scaffold(
          backgroundColor: AppColors.white,
          bottomNavigationBar: MediaQuery.of(context).viewInsets.bottom > 0
              ? null
              : BtnNavWidget(
                  tabs: BtnNavCubit.tabs,
                  activeIndex: state.currentIndex,
                  onTap: cubit.changeIndex,
                ),
          // IndexedStack يُبقي كل التبويبات حيّة (تُبنى مرة واحدة) فلا يُعاد تحميل
          // البيانات عند التنقّل بينها.
          body: IndexedStack(index: state.currentIndex, children: pages),
        );
      },
    );
  }
}
