import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workspace/features/auth/data/datasources/google_auth_service.dart';
import 'package:workspace/features/auth/domain/usecases/google_login_usecase.dart';
import 'package:workspace/features/auth/domain/usecases/register_usecase.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;
  final GoogleLoginUseCase googleLoginUseCase;
  final GoogleAuthService googleAuthService;

  RegisterCubit({
    required this.registerUseCase,
    required this.googleLoginUseCase,
    required this.googleAuthService,
  }) : super(const RegisterState());

  void togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword));
  }

  void setType(String serverType) {
    emit(state.copyWith(selectedType: serverType));
  }

  Future<void> register({
    required String name,
    required String email,
    required String mobile,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(state.copyWith(status: RegisterStatus.loading, errorMessage: ''));
    final result = await registerUseCase(RegisterParams(
      name: name,
      type: state.selectedType,
      email: email,
      mobile: mobile,
      password: password,
      passwordConfirmation: passwordConfirmation,
    ));
    result.fold(
      (failure) => emit(state.copyWith(
        status: RegisterStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(
        status: RegisterStatus.success,
        registeredEmail: email,
      )),
    );
  }

  Future<void> startGoogleSignIn() async {
    emit(state.copyWith(status: RegisterStatus.googleLoading, errorMessage: ''));
    try {
      final accessToken = await googleAuthService.signIn();
      if (accessToken == null) {
        emit(state.copyWith(status: RegisterStatus.initial));
        return;
      }
      emit(state.copyWith(
        status: RegisterStatus.googleAwaitingType,
        googleAccessToken: accessToken,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: RegisterStatus.failure,
        errorMessage: 'تعذّر تسجيل الدخول عبر Google',
      ));
    }
  }

  Future<void> completeGoogleSignIn(String type) async {
    emit(state.copyWith(status: RegisterStatus.googleLoading));
    final result = await googleLoginUseCase(
      GoogleLoginParams(accessToken: state.googleAccessToken, type: type),
    );
    result.fold(
      (failure) => emit(state.copyWith(
        status: RegisterStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(status: RegisterStatus.success)),
    );
  }
}
