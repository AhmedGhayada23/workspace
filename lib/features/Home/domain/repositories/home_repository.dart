import 'package:dartz/dartz.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/features/Home/domain/entities/home_profile.dart';
import 'package:workspace/features/Home/domain/entities/main_page.dart';

abstract class HomeRepository {
  /// [filterProfit] null = الكل، 'non-profit' أو 'profit'.
  Future<Either<Failure, MainPage>> getMainPage(String? filterProfit);

  Future<Either<Failure, HomeProfile>> getProfileHeader();
}
