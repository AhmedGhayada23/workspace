class Constants {
  static const int receiveTimeout = 60000;
  static const int connectionTimeout = 60000;
  static const String baseUrl = 'https://mobile.areistospace.com/api';
  static const String imageUrl = 'https://mobile.areistospace.com/uploads/';
  static const String loginApi = '/v1/auth/login';
  static const String registerApi = '/v1/auth/register';
  static const String forgetPasswordSendCodeApi =
      '/v1/forget-password/send-code';
  static const String checkCodeActiveApi = '/v1/auth/check-code-for-activate';
  static const String checkCodeForgetPasswordApi =
      '/v1/forget-password/check-code';
  static const String sentCodeForDeleteAccountApi =
      '/v1/profile/send-code-for-delete-account';
  static const String chechCodeForDeleteAccountApi =
      '/v1/profile/check-code-for-delete-account';
  static const String forgetPasswordResetPasswordApi =
      '/v1/forget-password/reset-password';
  static const String updatePasswordApi = '/v1/profile/update-password';
  static const String profileMeApi = '/v1/profile/me';
  static const String logoutApi = '/v1/auth/logout';
  static const String spacesApi = '/v1/spaces';
  static const String mainPageApi = '/v1/main-page';
  static const String reservationsApi = '/v1/reservations';
  static const String settingAccountApi = '/v1/profile/update-data-part2';
  static const String editAccountApi = '/v1/profile/update-data-part1';
  static const String ratingApi = '/v1/spaces-evaluation';
  static const String googleLoginApi = '/v1/auth/google-login';
  static const String storeTokenApi = '/v1/store-token';
  static const String concelReservationsApi = '/v1/reservations/cancel';
  static const String re_ReservationApi = '/v1/reservations/re-reservation';
  static const String notificationsApi = '/v1/notifications';
  static const String readNotificationsApi =
      '/v1/notifications/mark-as-read-all';

  static const String token = 'token';
  static const String unreadNotification = 'hasUnreadNotification';
  static const String searchList = 'searchList';
  static const String userType = 'userType';
  static const String onBorder = 'onBorder';
}
