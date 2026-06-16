
import 'package:get/get.dart';
import 'package:workspace/features/Home/bindings/home_binding.dart';
import 'package:workspace/features/Home/presentation/views/home_view.dart';
import 'package:workspace/features/all_space/bindings/all_space_binding.dart';
import 'package:workspace/features/all_space/presentation/views/all_space_view.dart';
import 'package:workspace/features/auth/bindings/congratulations_binding.dart';
import 'package:workspace/features/auth/bindings/new_password_binding.dart';
import 'package:workspace/features/auth/bindings/otp_binding.dart';
import 'package:workspace/features/auth/bindings/reset_password_binding.dart';
import 'package:workspace/features/auth/bindings/sign_in_binding.dart';
import 'package:workspace/features/auth/bindings/sign_up_binding.dart';
import 'package:workspace/features/auth/presentation/views/congratulations_view.dart';
import 'package:workspace/features/auth/presentation/views/new_password_view.dart';
import 'package:workspace/features/auth/presentation/views/otp_view.dart';
import 'package:workspace/features/auth/presentation/views/reset_password_view.dart';
import 'package:workspace/features/auth/presentation/views/sigin_in_view.dart';
import 'package:workspace/features/auth/presentation/views/sigin_up_view.dart';
import 'package:workspace/features/booking/bindings/booking_binding.dart';
import 'package:workspace/features/booking/bindings/confirm_booking_binding.dart';
import 'package:workspace/features/booking/presentation/views/booking_view.dart';
import 'package:workspace/features/booking/presentation/views/confirm_booking_view.dart';
import 'package:workspace/features/bottom_navigation_bar/bindings/btn_nav_binding.dart';
import 'package:workspace/features/bottom_navigation_bar/presentation/views/btn_nav_view.dart';
import 'package:workspace/features/delete_account/bindings/delete_account_sent_otp_binding.dart';
import 'package:workspace/features/delete_account/bindings/delete_account_verification_code_binding.dart';
import 'package:workspace/features/delete_account/bindings/reasons_account_deletion_binding.dart';
import 'package:workspace/features/delete_account/presentation/views/delete_account_sent_otp_view.dart';
import 'package:workspace/features/delete_account/presentation/views/delete_account_verification_code_view.dart';
import 'package:workspace/features/delete_account/presentation/views/reasons_account_deletion_view.dart';
import 'package:workspace/features/details_space/bindings/details_space_binding.dart';
import 'package:workspace/features/details_space/presentation/views/details_space_view.dart';
import 'package:workspace/features/my_reservations/bindings/details_my_reservation_binding.dart';
import 'package:workspace/features/my_reservations/bindings/my_reservations_binding.dart';
import 'package:workspace/features/my_reservations/presentation/views/details_my_reservation_view.dart';
import 'package:workspace/features/my_reservations/presentation/views/my_reservations_view.dart';
import 'package:workspace/features/notification/bindings/notifcation_binding.dart';
import 'package:workspace/features/notification/presentation/views/notifcation_view.dart';
import 'package:workspace/features/profile/bindings/change_password_binding.dart';
import 'package:workspace/features/profile/bindings/edit_profile_binding.dart';
import 'package:workspace/features/profile/bindings/profile_binding.dart';
import 'package:workspace/features/profile/bindings/setting_profile_binding.dart';
import 'package:workspace/features/profile/presentation/views/change_password_view.dart';
import 'package:workspace/features/profile/presentation/views/edit_profile_view.dart';
import 'package:workspace/features/profile/presentation/views/profile_view.dart';
import 'package:workspace/features/profile/presentation/views/setting_profile_view.dart';
import 'package:workspace/features/search/bindings/search_binding.dart';
import 'package:workspace/features/search/presentation/views/search_view.dart';
import 'package:workspace/features/splash/bindings/loading_binding.dart';
import 'package:workspace/features/splash/bindings/splash_binding.dart';
import 'package:workspace/features/splash/presentation/views/loading_view.dart';
import 'package:workspace/features/splash/presentation/views/splash_view.dart';
import 'package:workspace/utils/routing.dart';

final List<GetPage> pages = <GetPage>[
  GetPage(
    name: AppRouting.loadingView,
    page: () => const LoadingView(),
    binding: LoadingBinding(),
  ),
  GetPage(
    name: AppRouting.signInView,
    page: () =>  SiginInView(),
    binding: SignInBinding(),
  ),
    GetPage(
    name: AppRouting.signUpView,
    page: () =>  SiginUpView(),
    binding: SignUpBinding(),
  ),
      GetPage(
    name: AppRouting.resetPasswordView,
    page: () =>  ResetPasswordView(),
    binding: ResetPasswordBiding(),
  ),
     GetPage(
    name: AppRouting.otpView,
    page: () =>  OTPView(),
    binding: OTPBinding(),
  ),
  GetPage(
    name: AppRouting.newPassordView,
    page: () =>  NewPasswordView(),
    binding: NewPasswordBinding(),
  ),
  GetPage(
    name: AppRouting.congratulationsView,
    page: () =>  CongratulationsView(),
    binding: CongratulationsBinding(),
  ),
  GetPage(
    name: AppRouting.btnNavView,
    page: () =>  BtnNavView(),
    binding: BtnNavBinding(),
  ),
    GetPage(
    name: AppRouting.homeView,
    page: () =>  HomeView(),
    binding: HomeBinding(),
  ),
    GetPage(
    name: AppRouting.searchHomeView,
    page: () =>  SearchView(),
    binding: SearchBinding(),
     transition: Transition.rightToLeft,
    transitionDuration: Duration(milliseconds: 100),
  ),
  GetPage(
    name: AppRouting.notifcationView,
    page: () =>  NotifcationView(),
    binding: NotificationBinding(),
  ),
   GetPage(
    name: AppRouting.allSpaceView,
    page: () =>  AllSpaceView(),
    binding: AllSpaceBinding(),
  ),
  GetPage(
    name: AppRouting.detailsView,
    page: () =>  DetailsSpaceView(),
    binding: DetailsSpaceBinding(),
  ),
    GetPage(
    name: AppRouting.bookingView,
    page: () =>  BookingView(),
    binding: BookingBinding(),
  ),
  GetPage(
    name: AppRouting.confirmBookingView,
    page: () =>  ConfirmBookingView(),
    binding: ConfirmBookingBinding(),
  ),
   GetPage(
    name: AppRouting.myReservationsView,
    page: () =>  MyReservationsView(),
    binding: MyReservationsBinding(),
  ),
  GetPage(
    name: AppRouting.detailsMyReservationsView,
    page: () =>  DetailsMyReservationView(),
    binding: DetailsMyReservationBinding(),
  ),
   GetPage(
    name: AppRouting.profileView,
    page: () =>  ProfileView(),
    binding: ProfileBinding(),
  ),
  GetPage(
    name: AppRouting.editProfileView,
    page: () =>  EditProfileView(),
    binding: EditProfileBinding(),
  ),
   GetPage(
    name: AppRouting.settingProfileView,
    page: () =>  SettingProfileView(),
    binding: SettingProfileBinding(),
  ),
     GetPage(
    name: AppRouting.changePasswordView,
    page: () =>  ChangePasswordView(),
    binding: ChangePasswordBinding(),
  ),
    GetPage(
    name: AppRouting.splashview,
    page: () =>  SplashView(),
    binding: SplashBinding(),
  ),
   GetPage(
    name: AppRouting.deleteAccountSentOtpView,
    page: () =>  DeleteAccountSentOtpView(),
    binding: DeleteAccountSentOtpBinding(),
  ),
   GetPage(
    name: AppRouting.deleteAccountVerificationCodeView,
    page: () =>  DeleteAccountVerificationCodeView(),
    binding: DeleteAccountVerificationCodeBinding(),
  ),
   GetPage(
    name: AppRouting.reasonsAccountDeletionView,
    page: () =>  ReasonsAccountDeletionView(),
    binding: ReasonsForAccountDeletionBinding(),
  ),
];
