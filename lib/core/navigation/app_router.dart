import 'package:flutter/material.dart';
import 'package:workspace/features/Home/presentation/views/home_view.dart';
import 'package:workspace/features/all_space/presentation/views/all_space_view.dart';
import 'package:workspace/features/auth/presentation/views/congratulations_view.dart';
import 'package:workspace/features/auth/presentation/views/new_password_view.dart';
import 'package:workspace/features/auth/presentation/views/otp_view.dart';
import 'package:workspace/features/auth/presentation/views/reset_password_view.dart';
import 'package:workspace/features/auth/presentation/views/sigin_in_view.dart';
import 'package:workspace/features/auth/presentation/views/sigin_up_view.dart';
import 'package:workspace/features/booking/presentation/views/booking_view.dart';
import 'package:workspace/features/booking/presentation/views/confirm_booking_view.dart';
import 'package:workspace/features/bottom_navigation_bar/presentation/views/btn_nav_view.dart';
import 'package:workspace/features/delete_account/presentation/views/delete_account_sent_otp_view.dart';
import 'package:workspace/features/delete_account/presentation/views/delete_account_verification_code_view.dart';
import 'package:workspace/features/delete_account/presentation/views/reasons_account_deletion_view.dart';
import 'package:workspace/features/details_space/data/model/details_space_model.dart';
import 'package:workspace/features/details_space/presentation/views/details_space_view.dart';
import 'package:workspace/features/my_reservations/data/models/order_model.dart';
import 'package:workspace/features/my_reservations/presentation/views/details_my_reservation_view.dart';
import 'package:workspace/features/my_reservations/presentation/views/my_reservations_view.dart';
import 'package:workspace/features/notification/presentation/views/notifcation_view.dart';
import 'package:workspace/features/profile/presentation/views/change_password_view.dart';
import 'package:workspace/features/profile/presentation/views/edit_profile_view.dart';
import 'package:workspace/features/profile/presentation/views/profile_view.dart';
import 'package:workspace/features/profile/presentation/views/setting_profile_view.dart';
import 'package:workspace/features/search/presentation/views/search_view.dart';
import 'package:workspace/features/splash/presentation/views/loading_view.dart';
import 'package:workspace/features/splash/presentation/views/splash_view.dart';
import 'package:workspace/utils/routing.dart';

/// مفتاح الـ Navigator العام — يتيح التنقّل وعرض الرسائل خارج شجرة الـ widgets.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// وسائط المسار — تجمع الكائن (arguments) والمعاملات النصّية (parameters)
/// في كائن واحد يُمرَّر عبر [RouteSettings.arguments].
class RouteArgs {
  final Object? arguments;
  final Map<String, String> parameters;

  const RouteArgs({this.arguments, this.parameters = const {}});

  static RouteArgs of(RouteSettings settings) {
    final a = settings.arguments;
    return a is RouteArgs ? a : const RouteArgs();
  }
}

/// مولّد المسارات لـ [MaterialApp.onGenerateRoute] (بديل GetX getPages).
Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  final args = RouteArgs.of(settings);

  Widget page;
  switch (settings.name) {
    case AppRouting.loadingView:
      page = const LoadingView();
      break;
    case AppRouting.splashview:
      page = const SplashView();
      break;
    case AppRouting.signInView:
      page = SiginInView();
      break;
    case AppRouting.signUpView:
      page = SiginUpView();
      break;
    case AppRouting.resetPasswordView:
      page = ResetPasswordView();
      break;
    case AppRouting.otpView:
      page = OTPView(
        email: args.parameters['email'] ?? '',
        isNewAccount: args.parameters['new'] == 'true',
      );
      break;
    case AppRouting.newPassordView:
      page = NewPasswordView(email: args.parameters['email'] ?? '');
      break;
    case AppRouting.congratulationsView:
      page = CongratulationsView();
      break;
    case AppRouting.btnNavView:
      final a = args.arguments;
      final index = (a is Map && a['bottomNavIndex'] != null)
          ? int.tryParse('${a['bottomNavIndex']}') ?? 0
          : 0;
      page = BtnNavView(initialIndex: index);
      break;
    case AppRouting.homeView:
      page = const HomeView();
      break;
    case AppRouting.searchHomeView:
      return _slideRoute(const SearchView(), settings);
    case AppRouting.notifcationView:
      page = const NotifcationView();
      break;
    case AppRouting.allSpaceView:
      page = const AllSpaceView();
      break;
    case AppRouting.detailsView:
      page = DetailsSpaceView(id: (args.arguments is int) ? args.arguments as int : 0);
      break;
    case AppRouting.bookingView:
      final a = (args.arguments is Map) ? args.arguments as Map<String, dynamic> : {};
      page = BookingView(
        space: a['space'] as Spaces,
        subscriptions: (a['subscriptions'] as List?) ?? const [],
        spaceId: args.parameters['id'] ?? '',
        isProfit: args.parameters['is_profit'] ?? 'true',
      );
      break;
    case AppRouting.confirmBookingView:
      page = ConfirmBookingView(
        space: args.arguments as Spaces,
        params: args.parameters,
      );
      break;
    case AppRouting.myReservationsView:
      page = const MyReservationsView();
      break;
    case AppRouting.detailsMyReservationsView:
      page = DetailsMyReservationView(reservation: args.arguments as Reservations);
      break;
    case AppRouting.profileView:
      page = const ProfileView();
      break;
    case AppRouting.editProfileView:
      page = const EditProfileView();
      break;
    case AppRouting.settingProfileView:
      page = const SettingProfileView();
      break;
    case AppRouting.changePasswordView:
      page = const ChangePasswordView();
      break;
    case AppRouting.deleteAccountSentOtpView:
      page = const DeleteAccountSentOtpView();
      break;
    case AppRouting.deleteAccountVerificationCodeView:
      page = DeleteAccountVerificationCodeView(email: args.parameters['email'] ?? '');
      break;
    case AppRouting.reasonsAccountDeletionView:
      page = const ReasonsAccountDeletionView();
      break;
    default:
      page = const LoadingView();
  }

  return MaterialPageRoute(builder: (_) => page, settings: settings);
}

/// انتقال انزلاقي من اليمين (للبحث) — مطابق لسلوك GetX السابق.
Route<dynamic> _slideRoute(Widget page, RouteSettings settings) {
  return PageRouteBuilder(
    settings: settings,
    transitionDuration: const Duration(milliseconds: 100),
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, animation, __, child) {
      final offset = Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
          .chain(CurveTween(curve: Curves.easeOut));
      return SlideTransition(position: animation.drive(offset), child: child);
    },
  );
}
