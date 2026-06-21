part of 'change_password_cubit.dart';

enum ChangePasswordStatus { idle, loading, success, failure }

class ChangePasswordState extends Equatable {
  final ChangePasswordStatus status;
  final bool obscureOld;
  final bool obscureNew;
  final bool obscureConfirm;
  final String message;

  const ChangePasswordState({
    this.status = ChangePasswordStatus.idle,
    this.obscureOld = true,
    this.obscureNew = true,
    this.obscureConfirm = true,
    this.message = '',
  });

  ChangePasswordState copyWith({
    ChangePasswordStatus? status,
    bool? obscureOld,
    bool? obscureNew,
    bool? obscureConfirm,
    String? message,
  }) {
    return ChangePasswordState(
      status: status ?? this.status,
      obscureOld: obscureOld ?? this.obscureOld,
      obscureNew: obscureNew ?? this.obscureNew,
      obscureConfirm: obscureConfirm ?? this.obscureConfirm,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, obscureOld, obscureNew, obscureConfirm, message];
}
