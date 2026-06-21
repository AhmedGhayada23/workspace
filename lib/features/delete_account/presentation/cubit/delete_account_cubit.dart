import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workspace/features/delete_account/domain/usecases/delete_account_usecases.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  final SendDeleteCodeUseCase sendDeleteCodeUseCase;
  final VerifyDeleteCodeUseCase verifyDeleteCodeUseCase;

  DeleteAccountCubit({
    required this.sendDeleteCodeUseCase,
    required this.verifyDeleteCodeUseCase,
  }) : super(const DeleteAccountState());

  Future<void> sendCode(String email) async {
    emit(state.copyWith(status: DeleteAccountStatus.loading));
    final result = await sendDeleteCodeUseCase(email);
    result.fold(
      (failure) => emit(state.copyWith(status: DeleteAccountStatus.failure, message: failure.message)),
      (_) => emit(state.copyWith(status: DeleteAccountStatus.codeSent)),
    );
  }

  Future<void> verifyCode({required String email, required String code}) async {
    emit(state.copyWith(status: DeleteAccountStatus.loading));
    final result = await verifyDeleteCodeUseCase(VerifyDeleteCodeParams(email: email, code: code));
    result.fold(
      (failure) => emit(state.copyWith(status: DeleteAccountStatus.failure, message: failure.message)),
      (_) => emit(state.copyWith(status: DeleteAccountStatus.deleted)),
    );
  }

  void resetStatus() => emit(state.copyWith(status: DeleteAccountStatus.idle));
}
