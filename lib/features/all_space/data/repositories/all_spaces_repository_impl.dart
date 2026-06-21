import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:workspace/core/error/exceptions.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/core/network/network_info.dart';
import 'package:workspace/features/all_space/data/datasources/all_spaces_remote_data_source.dart';
import 'package:workspace/features/all_space/domain/entities/spaces_page.dart';
import 'package:workspace/features/all_space/domain/repositories/all_spaces_repository.dart';

class AllSpacesRepositoryImpl implements AllSpacesRepository {
  final AllSpacesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AllSpacesRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, SpacesPage>> getSpaces({
    required int page,
    required int provinceId,
    String? profitFilter,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }
    try {
      final result = await remoteDataSource.getSpaces(
        page: page,
        provinceId: provinceId,
        profitFilter: profitFilter,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'تعذّر الاتصال بالخادم'));
    } catch (_) {
      return const Left(ServerFailure());
    }
  }
}
