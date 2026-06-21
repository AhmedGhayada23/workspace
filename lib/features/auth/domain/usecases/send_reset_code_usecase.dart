import 'package:dartz/dartz.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/core/usecases/usecase.dart';
import 'package:workspace/features/auth/domain/repositories/auth_repository.dart';

class SendResetCodeUseCase implements UseCase<Unit, String> {
  final AuthRepository repository;

  SendResetCodeUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(String email) {
    return repository.sendResetCode(email);
  }
}
