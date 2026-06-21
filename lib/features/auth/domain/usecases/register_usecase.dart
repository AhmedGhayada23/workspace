import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/core/usecases/usecase.dart';
import 'package:workspace/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase implements UseCase<Unit, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(RegisterParams params) {
    return repository.register(
      name: params.name,
      type: params.type,
      email: params.email,
      mobile: params.mobile,
      password: params.password,
      passwordConfirmation: params.passwordConfirmation,
    );
  }
}

class RegisterParams extends Equatable {
  final String name;
  final String type;
  final String email;
  final String mobile;
  final String password;
  final String passwordConfirmation;

  const RegisterParams({
    required this.name,
    required this.type,
    required this.email,
    required this.mobile,
    required this.password,
    required this.passwordConfirmation,
  });

  @override
  List<Object?> get props =>
      [name, type, email, mobile, password, passwordConfirmation];
}
