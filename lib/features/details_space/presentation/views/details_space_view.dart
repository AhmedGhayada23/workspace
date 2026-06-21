import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/local_storage.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:workspace/core/navigation/app_navigator.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/widgets/booking_success_popup_widget.dart';
import 'package:workspace/core/widgets/login_required_popup.dart';
import 'package:workspace/features/details_space/data/model/details_space_model.dart';
import 'package:workspace/features/details_space/presentation/cubit/details_cubit.dart';
import 'package:workspace/features/details_space/presentation/widgets/booking_bottom_bar.dart';
import 'package:workspace/features/details_space/presentation/widgets/details_media.dart';
import 'package:workspace/features/details_space/presentation/widgets/details_tabs.dart';
import 'package:workspace/features/details_space/presentation/widgets/information_about_space_widget.dart';

class DetailsSpaceView extends StatelessWidget {
  final int id;

  const DetailsSpaceView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DetailsCubit>()..load(id),
      child: const _DetailsBody(),
    );
  }
}

class _DetailsBody extends StatefulWidget {
  const _DetailsBody();

  @override
  State<_DetailsBody> createState() => _DetailsBodyState();
}

class _DetailsBodyState extends State<_DetailsBody> with TickerProviderStateMixin {
  final _nav = sl<AppNavigator>();
  late final TabController _tabController;
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _videoInitialized = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: detailsTabs.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> _initVideo(String url) async {
    if (_videoInitialized) return;
    _videoInitialized = true;
    try {
      _videoController = VideoPlayerController.networkUrl(
        Uri.parse(url),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );
      await _videoController!.initialize();
      _chewieController = ChewieController(
        videoPlayerController: _videoController!,
        aspectRatio: _videoController!.value.aspectRatio,
        autoPlay: true,
        looping: true,
      );
      if (mounted) setState(() {});
    } catch (_) {
      // فشل تحميل الفيديو — تُعرض الصورة بدلاً منه
    }
  }

  void _onState(BuildContext context, DetailsState state) {
    if (state.status == DetailsStatus.loaded) {
      final videoUrl = state.model?.data?.spaces?.videoUrl;
      if (videoUrl != null && videoUrl.isNotEmpty) _initVideo(videoUrl);
    }
    if (state.bookingStatus == BookingStatus.success) {
      context.read<DetailsCubit>().resetBooking();
      showDialog(context: context, builder: (_) => const BookingSuccessPopup());
    } else if (state.bookingStatus == BookingStatus.failure) {
      context.read<DetailsCubit>().resetBooking();
      showCustomSnackBar(context, state.errorMessage, SnackBarType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailsCubit, DetailsState>(
      listener: _onState,
      builder: (context, state) {
        final cubit = context.read<DetailsCubit>();
        final loading = state.status != DetailsStatus.loaded;
        final space = state.model?.data?.spaces;
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: _appBar(loading, space),
          bottomNavigationBar: loading
              ? null
              : BookingBottomBar(
                  isLoading: state.bookingStatus == BookingStatus.loading,
                  onTap: () => _onBookTap(context, cubit, space!),
                ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
              child: Skeletonizer(
                enabled: loading,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailsMedia(
                      space: loading ? null : space,
                      chewieController: loading ? null : _chewieController,
                    ),
                    loading
                        ? _loadingInfo()
                        : InformationAboutSpaceWidget.fromSpace(space!, cubit.availableText()),
                    SizedBox(height: 24.h),
                    DetailsTabBar(controller: _tabController),
                    SizedBox(height: 16.h),
                    loading
                        ? const DetailsTabContentLoading()
                        : DetailsTabContent(
                            data: state.model?.data,
                            tabIndex: _tabController.index,
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _appBar(bool loading, Spaces? space) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0.0,
      leading: IconButton(onPressed: _nav.back, icon: const Icon(Icons.arrow_back)),
      centerTitle: true,
      title: loading
          ? const SizedBox.shrink()
          : Text(
              '${space?.company?.name} - ${space?.province?.name}',
              textAlign: TextAlign.right,
              style: GoogleFonts.tajawal(
                color: const Color(0xFF212121),
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
    );
  }

  void _onBookTap(BuildContext context, DetailsCubit cubit, Spaces space) {
    // الزائر لا حساب له → اطلب تسجيل الدخول قبل الحجز.
    final isVisitor = sl<LocalStorage>().readValue<String>(Constants.userType) == 'visitor';
    if (isVisitor) {
      showLoginRequiredPopup(context);
      return;
    }

    final isNonProfit = space.company?.type != 'profit';
    final hasSubscriptions = space.subscriptions?.isNotEmpty ?? false;

    if (isNonProfit && hasSubscriptions) {
      showBookingTypeSheet(
        context,
        onPaid: () => _goToBooking(space),
        onFree: () => cubit.confirmNonProfit(space.id!),
      );
    } else if (isNonProfit && !hasSubscriptions) {
      cubit.confirmNonProfit(space.id!);
    } else {
      _goToBooking(space);
    }
  }

  void _goToBooking(Spaces space) {
    _nav.toBooking(
      arguments: {'subscriptions': space.subscriptions, 'space': space},
      parameters: {'id': space.id.toString(), 'is_profit': 'true'},
    );
  }

  /// معلومات وهمية تُعرض كهيكل عظمي أثناء التحميل.
  Widget _loadingInfo() {
    return const InformationAboutSpaceWidget(
      nameSpace: 'مساحة عمل اريستو',
      typeTitle: 'مشتركة',
      ratingCount: '12',
      ratingAverage: '4.5',
      address: 'غزة - شارع الجلاء',
      available: '09:00 صباحًا - 05:00 مساءً',
      mobile: '0591234567',
      email: 'info@aristospace.com',
      customersCount: '20',
      nameCompany: 'محمد عبد الله',
      imageCompany: '',
    );
  }
}
