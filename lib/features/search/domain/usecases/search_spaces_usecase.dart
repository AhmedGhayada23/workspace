import 'package:dartz/dartz.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/core/usecases/usecase.dart';
import 'package:workspace/features/search/domain/entities/search_result.dart';
import 'package:workspace/features/search/domain/repositories/search_repository.dart';

class SearchSpacesUseCase implements UseCase<List<SearchResultItem>, String> {
  final SearchRepository repository;

  SearchSpacesUseCase(this.repository);

  @override
  Future<Either<Failure, List<SearchResultItem>>> call(String text) {
    return repository.search(text);
  }
}
