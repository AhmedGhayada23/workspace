import 'package:dartz/dartz.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/features/search/domain/entities/search_result.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<SearchResultItem>>> search(String text);
}
