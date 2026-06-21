import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/core/usecases/usecase.dart';
import 'package:workspace/features/auth/domain/entities/auth_token.dart';
import 'package:workspace/features/auth/domain/repositories/auth_repository.dart';

class GoogleLoginUseCase implements UseCase<AuthToken, GoogleLoginParams> {
  final AuthRepository repository;

  GoogleLoginUseCase(this.repository);

  @override
  Future<Either<Failure, AuthToken>> call(GoogleLoginParams params) {
    return repository.googleLogin(
      accessToken: params.accessToken,
      type: params.type,
    );
  }
}

class GoogleLoginParams extends Equatable {
  final String accessToken;
  final String type;

  const GoogleLoginParams({required this.accessToken, required this.type});

  @override
  List<Object?> get props => [accessToken, type];
}
