import 'package:dartz/dartz.dart';
import 'package:workspace/core/error/failures.dart';
import 'package:workspace/features/details_space/data/model/details_space_model.dart';

/// ملاحظة: النموذج المتشعّب [DetailsSpaceModel] يُمرَّر كما هو عبر الطبقات
/// (يقوم مقام الكيان) لأن إعادة بنائه إلى entities تتطلب إعادة كتابة كل الـ widgets.
abstract class DetailsRepository {
  Future<Either<Failure, DetailsSpaceModel>> getDetails(int id);

  Future<Either<Failure, Unit>> bookNonProfit(int spaceId);
}
