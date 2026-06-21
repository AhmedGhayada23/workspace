import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workspace/features/auth/domain/usecases/reset_password_usecase.dart';

part 'new_password_state.dart';

class NewPasswordCubit extends Cubit<NewPasswordState> {
  final ResetPasswordUseCase resetPasswordUseCase;

  NewPasswordCubit(this.resetPasswordUseCase) : super(const NewPasswordState());

  void togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword));
  }

  Future<void> submit({
    required String email,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    emit(state.copyWith(status: NewPasswordStatus.loading, errorMessage: ''));
    final result = await resetPasswordUseCase(ResetPasswordParams(
      email: email,
      newPassword: newPassword,
      confirmNewPassword: confirmNewPassword,
    ));
    result.fold(
      (failure) => emit(state.copyWith(
        status: NewPasswordStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(status: NewPasswordStatus.success)),
    );
  }
}
