import 'package:dartz/dartz.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/features/all_space/domain/entities/spaces_page.dart';

abstract class AllSpacesRepository {
  Future<Either<Failure, SpacesPage>> getSpaces({
    required int page,
    required int provinceId,
    String? profitFilter,
  });
}
