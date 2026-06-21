import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/core/usecases/usecase.dart';
import 'package:workspace/features/auth/domain/entities/auth_token.dart';
import 'package:workspace/features/auth/domain/repositories/auth_repository.dart';

/// التحقق من رمز تفعيل حساب جديد (يُعيد التوكن).
class VerifyActivationCodeUseCase implements UseCase<AuthToken, VerifyCodeParams> {
  final AuthRepository repository;

  VerifyActivationCodeUseCase(this.repository);

  @override
  Future<Either<Failure, AuthToken>> call(VerifyCodeParams params) {
    return repository.verifyActivationCode(email: params.email, code: params.code);
  }
}

/// التحقق من رمز استعادة كلمة المرور.
class VerifyForgotPasswordCodeUseCase implements UseCase<Unit, VerifyCodeParams> {
  final AuthRepository repository;

  VerifyForgotPasswordCodeUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(VerifyCodeParams params) {
    return repository.verifyForgotPasswordCode(email: params.email, code: params.code);
  }
}

class VerifyCodeParams extends Equatable {
  final String email;
  final String code;

  const VerifyCodeParams({required this.email, required this.code});

  @override
  List<Object?> get props => [email, code];
}
