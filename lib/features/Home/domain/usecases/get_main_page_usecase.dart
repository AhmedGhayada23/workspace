import 'package:dartz/dartz.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/core/usecases/usecase.dart';
import 'package:workspace/features/Home/domain/entities/main_page.dart';
import 'package:workspace/features/Home/domain/repositories/home_repository.dart';

class GetMainPageUseCase implements UseCase<MainPage, String?> {
  final HomeRepository repository;

  GetMainPageUseCase(this.repository);

  @override
  Future<Either<Failure, MainPage>> call(String? filterProfit) {
    return repository.getMainPage(filterProfit);
  }
}
