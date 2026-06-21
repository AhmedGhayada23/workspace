import 'package:dartz/dartz.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/core/usecases/usecase.dart';
import 'package:workspace/features/details_space/data/model/details_space_model.dart';
import 'package:workspace/features/details_space/domain/repositories/details_repository.dart';

class GetDetailsUseCase implements UseCase<DetailsSpaceModel, int> {
  final DetailsRepository repository;

  GetDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, DetailsSpaceModel>> call(int id) {
    return repository.getDetails(id);
  }
}
