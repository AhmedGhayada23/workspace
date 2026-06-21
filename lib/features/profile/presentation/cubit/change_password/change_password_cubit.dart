import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workspace/features/profile/domain/usecases/profile_usecases.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase changePasswordUseCase;

  ChangePasswordCubit(this.changePasswordUseCase) : super(const ChangePasswordState());

  void toggleOld() => emit(state.copyWith(obscureOld: !state.obscureOld));
  void toggleNew() => emit(state.copyWith(obscureNew: !state.obscureNew));
  void toggleConfirm() => emit(state.copyWith(obscureConfirm: !state.obscureConfirm));

  Future<void> submit({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(state.copyWith(status: ChangePasswordStatus.loading));
    final result = await changePasswordUseCase(ChangePasswordParams(
      oldPassword: oldPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    ));
    result.fold(
      (failure) => emit(state.copyWith(
        status: ChangePasswordStatus.failure,
        message: failure.message,
      )),
      (message) => emit(state.copyWith(
        status: ChangePasswordStatus.success,
        message: message,
      )),
    );
  }

  void clearStatus() => emit(state.copyWith(status: ChangePasswordStatus.idle));
}
