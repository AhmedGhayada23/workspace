part of 'otp_cubit.dart';

enum OtpStatus { initial, loading, success, failure }

class OtpState extends Equatable {
  final OtpStatus status;
  final int secondsRemaining;
  final bool canResend;
  final String errorMessage;
  final String email;
  final bool isNewAccount;

  const OtpState({
    this.status = OtpStatus.initial,
    this.secondsRemaining = 60,
    this.canResend = false,
    this.errorMessage = '',
    this.email = '',
    this.isNewAccount = false,
  });

  /// الوقت المنسّق mm : ss
  String get formattedTime {
    final minutes = secondsRemaining ~/ 60;
    final seconds = secondsRemaining % 60;
    return '${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}';
  }

  OtpState copyWith({
    OtpStatus? status,
    int? secondsRemaining,
    bool? canResend,
    String? errorMessage,
    String? email,
    bool? isNewAccount,
  }) {
    return OtpState(
      status: status ?? this.status,
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      canResend: canResend ?? this.canResend,
      errorMessage: errorMessage ?? this.errorMessage,
      email: email ?? this.email,
      isNewAccount: isNewAccount ?? this.isNewAccount,
    );
  }

  @override
  List<Object?> get props =>
      [status, secondsRemaining, canResend, errorMessage, email, isNewAccount];
}
