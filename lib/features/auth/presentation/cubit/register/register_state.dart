part of 'register_cubit.dart';

enum RegisterStatus {
  initial,
  loading,
  success,
  failure,
  googleAwaitingType,
  googleLoading,
}

class RegisterState extends Equatable {
  final RegisterStatus status;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final String selectedType; // قيمة الخادم للقسم المختار
  final String errorMessage;
  final String registeredEmail; // يُمرَّر لشاشة OTP
  final String googleAccessToken;

  const RegisterState({
    this.status = RegisterStatus.initial,
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.selectedType = '',
    this.errorMessage = '',
    this.registeredEmail = '',
    this.googleAccessToken = '',
  });

  RegisterState copyWith({
    RegisterStatus? status,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    String? selectedType,
    String? errorMessage,
    String? registeredEmail,
    String? googleAccessToken,
  }) {
    return RegisterState(
      status: status ?? this.status,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
      selectedType: selectedType ?? this.selectedType,
      errorMessage: errorMessage ?? this.errorMessage,
      registeredEmail: registeredEmail ?? this.registeredEmail,
      googleAccessToken: googleAccessToken ?? this.googleAccessToken,
    );
  }

  @override
  List<Object?> get props => [
        status,
        obscurePassword,
        obscureConfirmPassword,
        selectedType,
        errorMessage,
        registeredEmail,
        googleAccessToken,
      ];
}
