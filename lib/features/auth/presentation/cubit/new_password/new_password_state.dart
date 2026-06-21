part of 'new_password_cubit.dart';

enum NewPasswordStatus { initial, loading, success, failure }

class NewPasswordState extends Equatable {
  final NewPasswordStatus status;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final String errorMessage;

  const NewPasswordState({
    this.status = NewPasswordStatus.initial,
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.errorMessage = '',
  });

  NewPasswordState copyWith({
    NewPasswordStatus? status,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    String? errorMessage,
  }) {
    return NewPasswordState(
      status: status ?? this.status,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, obscurePassword, obscureConfirmPassword, errorMessage];
}
