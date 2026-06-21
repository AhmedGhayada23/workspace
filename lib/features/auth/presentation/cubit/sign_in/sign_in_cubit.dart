import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workspace/features/auth/data/datasources/google_auth_service.dart';
import 'package:workspace/features/auth/domain/usecases/google_login_usecase.dart';
import 'package:workspace/features/auth/domain/usecases/sign_in_usecase.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInUseCase signInUseCase;
  final GoogleLoginUseCase googleLoginUseCase;
  final GoogleAuthService googleAuthService;

  SignInCubit({
    required this.signInUseCase,
    required this.googleLoginUseCase,
    required this.googleAuthService,
  }) : super(const SignInState());

  void togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void toggleRememberMe(bool value) {
    emit(state.copyWith(rememberMe: value));
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(state.copyWith(status: SignInStatus.loading, errorMessage: ''));
    final result = await signInUseCase(SignInParams(email: email, password: password));
    result.fold(
      (failure) => emit(state.copyWith(
        status: SignInStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(status: SignInStatus.success)),
    );
  }

  /// الخطوة الأولى لتسجيل دخول Google: فتح نافذة Google والحصول على التوكن.
  Future<void> startGoogleSignIn() async {
    emit(state.copyWith(status: SignInStatus.googleLoading, errorMessage: ''));
    try {
      final accessToken = await googleAuthService.signIn();
      if (accessToken == null) {
        // ألغى المستخدم العملية
        emit(state.copyWith(status: SignInStatus.initial));
        return;
      }
      emit(state.copyWith(
        status: SignInStatus.googleAwaitingType,
        googleAccessToken: accessToken,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SignInStatus.failure,
        errorMessage: 'تعذّر تسجيل الدخول عبر Google',
      ));
    }
  }

  /// الخطوة الثانية: إرسال التوكن مع القسم المختار إلى الخادم.
  Future<void> completeGoogleSignIn(String type) async {
    emit(state.copyWith(status: SignInStatus.googleLoading));
    final result = await googleLoginUseCase(
      GoogleLoginParams(accessToken: state.googleAccessToken, type: type),
    );
    result.fold(
      (failure) => emit(state.copyWith(
        status: SignInStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(status: SignInStatus.success)),
    );
  }
}
