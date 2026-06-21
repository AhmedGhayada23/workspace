import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:workspace/core/config/storage/local_storage.dart';
import 'package:workspace/core/config/storage/remote_dio.dart';
import 'package:workspace/core/navigation/app_navigator.dart';
import 'package:workspace/core/navigation/flutter_app_navigator.dart';
import 'package:workspace/core/network/network_info.dart';
import 'package:workspace/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:workspace/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:workspace/features/auth/data/datasources/google_auth_service.dart';
import 'package:workspace/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:workspace/features/auth/domain/repositories/auth_repository.dart';
import 'package:workspace/features/auth/domain/usecases/google_login_usecase.dart';
import 'package:workspace/features/auth/domain/usecases/register_usecase.dart';
import 'package:workspace/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:workspace/features/auth/domain/usecases/send_reset_code_usecase.dart';
import 'package:workspace/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:workspace/features/auth/domain/usecases/verify_code_usecase.dart';
import 'package:workspace/features/auth/presentation/cubit/new_password/new_password_cubit.dart';
import 'package:workspace/features/auth/presentation/cubit/otp/otp_cubit.dart';
import 'package:workspace/features/auth/presentation/cubit/register/register_cubit.dart';
import 'package:workspace/features/auth/presentation/cubit/reset_password/reset_password_cubit.dart';
import 'package:workspace/features/auth/presentation/cubit/sign_in/sign_in_cubit.dart';
import 'package:workspace/core/services/notification_service.dart';
import 'package:workspace/core/services/fcm_token_service.dart';
import 'package:workspace/features/Home/data/datasources/home_remote_data_source.dart';
import 'package:workspace/features/Home/data/repositories/home_repository_impl.dart';
import 'package:workspace/features/Home/domain/repositories/home_repository.dart';
import 'package:workspace/features/Home/domain/usecases/get_home_profile_usecase.dart';
import 'package:workspace/features/Home/domain/usecases/get_main_page_usecase.dart';
import 'package:workspace/features/Home/presentation/cubit/home_cubit.dart';
import 'package:workspace/features/bottom_navigation_bar/presentation/cubit/btn_nav_cubit.dart';
import 'package:workspace/features/all_space/data/datasources/all_spaces_remote_data_source.dart';
import 'package:workspace/features/all_space/data/repositories/all_spaces_repository_impl.dart';
import 'package:workspace/features/all_space/domain/repositories/all_spaces_repository.dart';
import 'package:workspace/features/all_space/domain/usecases/get_all_spaces_usecase.dart';
import 'package:workspace/features/all_space/presentation/cubit/all_space_cubit.dart';
import 'package:workspace/features/search/data/datasources/search_remote_data_source.dart';
import 'package:workspace/features/search/data/repositories/search_repository_impl.dart';
import 'package:workspace/features/search/domain/repositories/search_repository.dart';
import 'package:workspace/features/search/domain/usecases/search_spaces_usecase.dart';
import 'package:workspace/features/search/presentation/cubit/search_cubit.dart';
import 'package:workspace/features/details_space/data/datasources/details_remote_data_source.dart';
import 'package:workspace/features/details_space/data/repositories/details_repository_impl.dart';
import 'package:workspace/features/details_space/domain/repositories/details_repository.dart';
import 'package:workspace/features/details_space/domain/usecases/book_non_profit_usecase.dart';
import 'package:workspace/features/details_space/domain/usecases/get_details_usecase.dart';
import 'package:workspace/features/details_space/presentation/cubit/details_cubit.dart';
import 'package:workspace/features/booking/data/datasources/booking_remote_data_source.dart';
import 'package:workspace/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:workspace/features/booking/domain/repositories/booking_repository.dart';
import 'package:workspace/features/booking/domain/usecases/confirm_booking_usecase.dart';
import 'package:workspace/features/booking/presentation/cubit/booking/booking_cubit.dart';
import 'package:workspace/features/booking/presentation/cubit/confirm_booking/confirm_booking_cubit.dart';
import 'package:workspace/features/my_reservations/data/datasources/reservations_remote_data_source.dart';
import 'package:workspace/features/my_reservations/data/repositories/reservations_repository_impl.dart';
import 'package:workspace/features/my_reservations/domain/repositories/reservations_repository.dart';
import 'package:workspace/features/my_reservations/domain/usecases/get_reservations_usecase.dart';
import 'package:workspace/features/my_reservations/domain/usecases/reservation_actions_usecase.dart';
import 'package:workspace/features/my_reservations/presentation/cubit/details_reservation/details_reservation_cubit.dart';
import 'package:workspace/features/my_reservations/presentation/cubit/my_reservations/my_reservations_cubit.dart';
import 'package:workspace/features/notification/data/datasources/notifications_remote_data_source.dart';
import 'package:workspace/features/notification/data/repositories/notifications_repository_impl.dart';
import 'package:workspace/features/notification/domain/repositories/notifications_repository.dart';
import 'package:workspace/features/notification/domain/usecases/notifications_usecases.dart';
import 'package:workspace/features/notification/presentation/cubit/notification_badge_cubit.dart';
import 'package:workspace/features/notification/presentation/cubit/notifications_cubit.dart';
import 'package:workspace/features/rating/data/datasources/rating_remote_data_source.dart';
import 'package:workspace/features/rating/data/repositories/rating_repository_impl.dart';
import 'package:workspace/features/rating/domain/repositories/rating_repository.dart';
import 'package:workspace/features/rating/domain/usecases/submit_rating_usecase.dart';
import 'package:workspace/features/rating/presentation/cubit/rating_cubit.dart';
import 'package:workspace/features/delete_account/data/datasources/delete_account_remote_data_source.dart';
import 'package:workspace/features/delete_account/data/repositories/delete_account_repository_impl.dart';
import 'package:workspace/features/delete_account/domain/repositories/delete_account_repository.dart';
import 'package:workspace/features/delete_account/domain/usecases/delete_account_usecases.dart';
import 'package:workspace/features/delete_account/presentation/cubit/delete_account_cubit.dart';
import 'package:workspace/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:workspace/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:workspace/features/profile/domain/repositories/profile_repository.dart';
import 'package:workspace/features/profile/domain/usecases/profile_usecases.dart';
import 'package:workspace/features/profile/presentation/cubit/change_password/change_password_cubit.dart';
import 'package:workspace/features/profile/presentation/cubit/edit_profile/edit_profile_cubit.dart';
import 'package:workspace/features/profile/presentation/cubit/profile/profile_cubit.dart';
import 'package:workspace/features/profile/presentation/cubit/setting_profile/setting_profile_cubit.dart';

/// حاوية حقن الاعتماديات. تُهيّأ مرة واحدة في main عبر [initDependencies].
final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  //========================== Features : Auth ==========================//

  // Cubits (factory: نسخة جديدة لكل شاشة)
  sl.registerFactory(() => SignInCubit(
        signInUseCase: sl(),
        googleLoginUseCase: sl(),
        googleAuthService: sl(),
      ));
  sl.registerFactory(() => RegisterCubit(
        registerUseCase: sl(),
        googleLoginUseCase: sl(),
        googleAuthService: sl(),
      ));
  sl.registerFactory(() => ResetPasswordCubit(sl()));
  sl.registerFactory(() => OtpCubit(
        verifyActivationCodeUseCase: sl(),
        verifyForgotPasswordCodeUseCase: sl(),
        sendResetCodeUseCase: sl(),
      ));
  sl.registerFactory(() => NewPasswordCubit(sl()));

  //==================== Features : Home + BottomNav ====================//
  sl.registerFactory(() => HomeCubit(
        getMainPageUseCase: sl(),
        localStorage: sl(),
      ));
  sl.registerFactory(() => BtnNavCubit(
        localStorage: sl(),
        notificationService: sl(),
        fcmTokenService: sl(),
      ));
  sl.registerFactory(() => AllSpaceCubit(
        getAllSpacesUseCase: sl(),
        localStorage: sl(),
      ));

  sl.registerLazySingleton(() => GetAllSpacesUseCase(sl()));
  sl.registerLazySingleton<AllSpacesRepository>(() => AllSpacesRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<AllSpacesRemoteDataSource>(
      () => AllSpacesRemoteDataSourceImpl(sl()));

  sl.registerFactory(() => SearchCubit(searchSpacesUseCase: sl(), localStorage: sl()));
  sl.registerLazySingleton(() => SearchSpacesUseCase(sl()));
  sl.registerLazySingleton<SearchRepository>(() => SearchRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<SearchRemoteDataSource>(() => SearchRemoteDataSourceImpl(sl()));

  sl.registerFactory(() => DetailsCubit(
        getDetailsUseCase: sl(),
        bookNonProfitUseCase: sl(),
      ));
  sl.registerLazySingleton(() => GetDetailsUseCase(sl()));
  sl.registerLazySingleton(() => BookNonProfitUseCase(sl()));
  sl.registerLazySingleton<DetailsRepository>(() => DetailsRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<DetailsRemoteDataSource>(() => DetailsRemoteDataSourceImpl(sl()));

  //======================== Features : Booking ========================//
  sl.registerFactory(() => BookingCubit());
  sl.registerFactory(() => ConfirmBookingCubit(sl()));
  sl.registerLazySingleton(() => ConfirmBookingUseCase(sl()));
  sl.registerLazySingleton<BookingRepository>(() => BookingRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<BookingRemoteDataSource>(() => BookingRemoteDataSourceImpl(sl()));

  //==================== Features : My Reservations ====================//
  sl.registerFactory(() => MyReservationsCubit(
        getReservationsUseCase: sl(),
        cancelReservationUseCase: sl(),
        reReserveUseCase: sl(),
      ));
  sl.registerFactory(() => DetailsReservationCubit(sl()));
  sl.registerLazySingleton(() => GetReservationsUseCase(sl()));
  sl.registerLazySingleton(() => CancelReservationUseCase(sl()));
  sl.registerLazySingleton(() => ReReserveUseCase(sl()));
  sl.registerLazySingleton(() => GetReservationDetailsUseCase(sl()));
  sl.registerLazySingleton<ReservationsRepository>(() => ReservationsRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<ReservationsRemoteDataSource>(
      () => ReservationsRemoteDataSourceImpl(sl()));

  //==================== Features : Notifications ====================//
  sl.registerFactory(() => NotificationsCubit(
        getNotificationsUseCase: sl(),
        markReadUseCase: sl(),
        localStorage: sl(),
      ));
  // singleton مشترك لعدّاد الإشعارات (الرئيسية + all_space).
  sl.registerLazySingleton(() => NotificationBadgeCubit(sl()));
  sl.registerLazySingleton(() => GetNotificationsUseCase(sl()));
  sl.registerLazySingleton(() => MarkNotificationsReadUseCase(sl()));
  sl.registerLazySingleton<NotificationsRepository>(() => NotificationsRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<NotificationsRemoteDataSource>(
      () => NotificationsRemoteDataSourceImpl(sl()));

  //==================== Features : Rating ====================//
  sl.registerFactory(() => RatingCubit(sl()));
  sl.registerLazySingleton(() => SubmitRatingUseCase(sl()));
  sl.registerLazySingleton<RatingRepository>(() => RatingRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<RatingRemoteDataSource>(() => RatingRemoteDataSourceImpl(sl()));

  //==================== Features : Delete Account ====================//
  sl.registerFactory(() => DeleteAccountCubit(
        sendDeleteCodeUseCase: sl(),
        verifyDeleteCodeUseCase: sl(),
      ));
  sl.registerLazySingleton(() => SendDeleteCodeUseCase(sl()));
  sl.registerLazySingleton(() => VerifyDeleteCodeUseCase(sl()));
  sl.registerLazySingleton<DeleteAccountRepository>(() => DeleteAccountRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<DeleteAccountRemoteDataSource>(
      () => DeleteAccountRemoteDataSourceImpl(sl()));

  sl.registerLazySingleton(() => GetMainPageUseCase(sl()));
  sl.registerLazySingleton(() => GetHomeProfileUseCase(sl()));
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl(sl()));

  // UseCases
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => GoogleLoginUseCase(sl()));
  sl.registerLazySingleton(() => SendResetCodeUseCase(sl()));
  sl.registerLazySingleton(() => VerifyActivationCodeUseCase(sl()));
  sl.registerLazySingleton(() => VerifyForgotPasswordCodeUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));

  // DataSources
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(sl()));
  sl.registerLazySingleton(() => GoogleAuthService(googleSignIn: sl(), firebaseAuth: sl()));

  //============================== Core ================================//
  //======================== Features : Profile ========================//
  // singleton ليُشارَك بين شاشة الحساب والشاشات التي تعدّله (لتحديثه بعد التعديل).
  sl.registerLazySingleton(() => ProfileCubit(getProfileUseCase: sl(), logoutUseCase: sl()));
  sl.registerFactory(() => ChangePasswordCubit(sl()));
  sl.registerFactory(() => SettingProfileCubit(editSettingsUseCase: sl(), getProfileUseCase: sl()));
  sl.registerFactory(() => EditProfileCubit(editProfileUseCase: sl(), getProfileUseCase: sl()));
  sl.registerLazySingleton(() => GetProfileUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => ChangePasswordUseCase(sl()));
  sl.registerLazySingleton(() => EditSettingsUseCase(sl()));
  sl.registerLazySingleton(() => EditProfileUseCase(sl()));
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
        localStorage: sl(),
        googleAuthService: sl(),
      ));
  sl.registerLazySingleton<ProfileRemoteDataSource>(() => ProfileRemoteDataSourceImpl(sl()));

  //============================== Core ================================//
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<AppNavigator>(() => FlutterAppNavigator());
  sl.registerLazySingleton<NotificationService>(() => NotificationService());
  sl.registerLazySingleton(() => FcmTokenService(sl()));

  //============================ External ==============================//
  sl.registerLazySingleton<Dio>(() => RemoteConnectionDio().dio);
  sl.registerLazySingleton<LocalStorage>(() => LocalStorage());
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn(scopes: const ['email']));
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
}
