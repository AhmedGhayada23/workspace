import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/core/usecases/usecase.dart';
import 'package:workspace/features/delete_account/domain/repositories/delete_account_repository.dart';

class SendDeleteCodeUseCase implements UseCase<Unit, String> {
  final DeleteAccountRepository repository;

  SendDeleteCodeUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(String email) => repository.sendCode(email);
}

class VerifyDeleteCodeUseCase implements UseCase<Unit, VerifyDeleteCodeParams> {
  final DeleteAccountRepository repository;

  VerifyDeleteCodeUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(VerifyDeleteCodeParams params) {
    return repository.verifyCode(email: params.email, code: params.code);
  }
}

class VerifyDeleteCodeParams extends Equatable {
  final String email;
  final String code;

  const VerifyDeleteCodeParams({required this.email, required this.code});

  @override
  List<Object?> get props => [email, code];
}
