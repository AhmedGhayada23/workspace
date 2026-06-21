import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workspace/features/auth/domain/usecases/send_reset_code_usecase.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final SendResetCodeUseCase sendResetCodeUseCase;

  ResetPasswordCubit(this.sendResetCodeUseCase) : super(const ResetPasswordState());

  Future<void> sendCode(String email) async {
    emit(state.copyWith(status: ResetPasswordStatus.loading, errorMessage: ''));
    final result = await sendResetCodeUseCase(email);
    result.fold(
      (failure) => emit(state.copyWith(
        status: ResetPasswordStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(status: ResetPasswordStatus.success)),
    );
  }
}
