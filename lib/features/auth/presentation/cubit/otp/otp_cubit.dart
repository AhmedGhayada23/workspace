import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workspace/features/auth/domain/usecases/send_reset_code_usecase.dart';
import 'package:workspace/features/auth/domain/usecases/verify_code_usecase.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final VerifyActivationCodeUseCase verifyActivationCodeUseCase;
  final VerifyForgotPasswordCodeUseCase verifyForgotPasswordCodeUseCase;
  final SendResetCodeUseCase sendResetCodeUseCase;

  Timer? _timer;

  OtpCubit({
    required this.verifyActivationCodeUseCase,
    required this.verifyForgotPasswordCodeUseCase,
    required this.sendResetCodeUseCase,
  }) : super(const OtpState());

  /// تهيئة الشاشة ببيانات التنقّل (البريد + هل الحساب جديد).
  void init({required String email, required bool isNewAccount}) {
    emit(state.copyWith(email: email, isNewAccount: isNewAccount));
    _startCountdown();
  }

  Future<void> verify(String code) async {
    emit(state.copyWith(status: OtpStatus.loading, errorMessage: ''));
    final result = state.isNewAccount
        ? await verifyActivationCodeUseCase(VerifyCodeParams(email: state.email, code: code))
        : await verifyForgotPasswordCodeUseCase(VerifyCodeParams(email: state.email, code: code));
    result.fold(
      (failure) => emit(state.copyWith(status: OtpStatus.failure, errorMessage: failure.message)),
      (_) {
        _timer?.cancel(); // إيقاف العدّاد عند نجاح التحقق
        emit(state.copyWith(status: OtpStatus.success));
      },
    );
  }

  Future<void> resend() async {
    if (!state.canResend) return;
    final result = await sendResetCodeUseCase(state.email);
    result.fold(
      (failure) => emit(state.copyWith(status: OtpStatus.failure, errorMessage: failure.message)),
      (_) => _startCountdown(),
    );
  }

  void _startCountdown() {
    _timer?.cancel();
    emit(state.copyWith(secondsRemaining: 60, canResend: false, status: OtpStatus.initial));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.secondsRemaining <= 1) {
        timer.cancel();
        emit(state.copyWith(secondsRemaining: 0, canResend: true));
      } else {
        emit(state.copyWith(secondsRemaining: state.secondsRemaining - 1));
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
