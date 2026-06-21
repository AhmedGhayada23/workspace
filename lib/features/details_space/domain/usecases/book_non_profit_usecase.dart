import 'package:dartz/dartz.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/core/usecases/usecase.dart';
import 'package:workspace/features/details_space/domain/repositories/details_repository.dart';

class BookNonProfitUseCase implements UseCase<Unit, int> {
  final DetailsRepository repository;

  BookNonProfitUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(int spaceId) {
    return repository.bookNonProfit(spaceId);
  }
}
