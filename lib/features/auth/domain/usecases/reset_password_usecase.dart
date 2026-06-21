import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/core/usecases/usecase.dart';
import 'package:workspace/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase implements UseCase<Unit, ResetPasswordParams> {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(ResetPasswordParams params) {
    return repository.resetPassword(
      email: params.email,
      newPassword: params.newPassword,
      confirmNewPassword: params.confirmNewPassword,
    );
  }
}

class ResetPasswordParams extends Equatable {
  final String email;
  final String newPassword;
  final String confirmNewPassword;

  const ResetPasswordParams({
    required this.email,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  @override
  List<Object?> get props => [email, newPassword, confirmNewPassword];
}
