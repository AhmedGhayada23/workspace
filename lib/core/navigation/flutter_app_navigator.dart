import 'package:flutter/widgets.dart';
import 'package:workspace/core/navigation/app_navigator.dart';
import 'package:workspace/core/navigation/app_router.dart';
import 'package:workspace/utils/routing.dart';

/// تنفيذ [AppNavigator] فوق Flutter Navigator (بلا GetX) عبر [navigatorKey].
class FlutterAppNavigator implements AppNavigator {
  NavigatorState get _nav => navigatorKey.currentState!;

  Future<T?> _push<T>(String route, {Object? arguments, Map<String, String> parameters = const {}}) {
    return _nav.pushNamed<T>(route, arguments: RouteArgs(arguments: arguments, parameters: parameters));
  }

  Future<T?> _replace<T>(String route,
      {Object? arguments, Map<String, String> parameters = const {}}) {
    return _nav.pushReplacementNamed<T, dynamic>(
      route,
      arguments: RouteArgs(arguments: arguments, parameters: parameters),
    );
  }

  Future<T?> _offAll<T>(String route,
      {Object? arguments, Map<String, String> parameters = const {}}) {
    return _nav.pushNamedAndRemoveUntil<T>(
      route,
      (_) => false,
      arguments: RouteArgs(arguments: arguments, parameters: parameters),
    );
  }

  @override
  void back() => _nav.pop();

  @override
  void toSignIn() => _push(AppRouting.signInView);

  @override
  void offAllToSignIn() => _offAll(AppRouting.signInView);

  @override
  void toSignUp() => _replace(AppRouting.signUpView);

  @override
  void toResetPassword() => _replace(AppRouting.resetPasswordView);

  @override
  void offAllToHome() => _offAll(AppRouting.btnNavView);

  @override
  void offAllToSplash() => _offAll(AppRouting.splashView);

  @override
  void offAllToHomeTab(int index) =>
      _offAll(AppRouting.btnNavView, arguments: {'bottomNavIndex': '$index'});

  @override
  void toOtp({required String email, required bool isNewAccount}) {
    _push(AppRouting.otpView, parameters: {
      'email': email,
      'new': isNewAccount ? 'true' : 'false',
    });
  }

  @override
  void toNewPassword({required String email}) =>
      _push(AppRouting.newPassordView, parameters: {'email': email});

  @override
  void offAllToCongratulations() => _offAll(AppRouting.congratulationsView);

  @override
  void toSearch() => _push(AppRouting.searchHomeView);

  @override
  void toNotifications() => _push(AppRouting.notifcationView);

  @override
  void toAllSpace() => _push(AppRouting.allSpaceView);

  @override
  void toDetails(int id) => _push(AppRouting.detailsView, arguments: id);

  @override
  void replaceToDetails(int id) {
    _nav.pushNamedAndRemoveUntil(
      AppRouting.detailsView,
      ModalRoute.withName(AppRouting.btnNavView),
      arguments: RouteArgs(arguments: id),
    );
  }

  @override
  void toBooking({
    required Map<String, dynamic> arguments,
    required Map<String, String> parameters,
  }) {
    _push(AppRouting.bookingView, arguments: arguments, parameters: parameters);
  }

  @override
  void toConfirmBooking({
    required Object arguments,
    required Map<String, String> parameters,
  }) {
    _push(AppRouting.confirmBookingView, arguments: arguments, parameters: parameters);
  }

  @override
  void toReservationDetails(Object reservation) =>
      _push(AppRouting.detailsMyReservationsView, arguments: reservation);

  @override
  void toEditProfile() => _push(AppRouting.editProfileView);

  @override
  void toSettingProfile() => _push(AppRouting.settingProfileView);

  @override
  void toChangePassword() => _push(AppRouting.changePasswordView);

  @override
  void toDeleteAccount() => _push(AppRouting.deleteAccountSentOtpView);

  @override
  void toDeleteAccountVerification(String email) =>
      _push(AppRouting.deleteAccountVerificationCodeView, parameters: {'email': email});
}
