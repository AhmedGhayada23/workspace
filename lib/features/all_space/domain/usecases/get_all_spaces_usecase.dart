import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/core/usecases/usecase.dart';
import 'package:workspace/features/all_space/domain/entities/spaces_page.dart';
import 'package:workspace/features/all_space/domain/repositories/all_spaces_repository.dart';

class GetAllSpacesUseCase implements UseCase<SpacesPage, AllSpacesParams> {
  final AllSpacesRepository repository;

  GetAllSpacesUseCase(this.repository);

  @override
  Future<Either<Failure, SpacesPage>> call(AllSpacesParams params) {
    return repository.getSpaces(
      page: params.page,
      provinceId: params.provinceId,
      profitFilter: params.profitFilter,
    );
  }
}

class AllSpacesParams extends Equatable {
  final int page;
  final int provinceId;
  final String? profitFilter;

  const AllSpacesParams({
    required this.page,
    required this.provinceId,
    this.profitFilter,
  });

  @override
  List<Object?> get props => [page, provinceId, profitFilter];
}
