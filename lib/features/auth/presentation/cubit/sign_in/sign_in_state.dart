part of 'sign_in_cubit.dart';

enum SignInStatus {
  initial,
  loading,
  success,
  failure,
  googleAwaitingType, // تمّ تسجيل دخول جوجل ونحتاج اختيار القسم
  googleLoading,
}

class SignInState extends Equatable {
  final SignInStatus status;
  final bool obscurePassword;
  final bool rememberMe;
  final String errorMessage;
  final String googleAccessToken;

  const SignInState({
    this.status = SignInStatus.initial,
    this.obscurePassword = true,
    this.rememberMe = false,
    this.errorMessage = '',
    this.googleAccessToken = '',
  });

  SignInState copyWith({
    SignInStatus? status,
    bool? obscurePassword,
    bool? rememberMe,
    String? errorMessage,
    String? googleAccessToken,
  }) {
    return SignInState(
      status: status ?? this.status,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      rememberMe: rememberMe ?? this.rememberMe,
      errorMessage: errorMessage ?? this.errorMessage,
      googleAccessToken: googleAccessToken ?? this.googleAccessToken,
    );
  }

  @override
  List<Object?> get props =>
      [status, obscurePassword, rememberMe, errorMessage, googleAccessToken];
}
