import 'package:dartz/dartz.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/core/usecases/usecase.dart';
import 'package:workspace/features/Home/domain/entities/home_profile.dart';
import 'package:workspace/features/Home/domain/repositories/home_repository.dart';

class GetHomeProfileUseCase implements UseCase<HomeProfile, NoParams> {
  final HomeRepository repository;

  GetHomeProfileUseCase(this.repository);

  @override
  Future<Either<Failure, HomeProfile>> call(NoParams params) {
    return repository.getProfileHeader();
  }
}
