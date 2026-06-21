import 'package:dartz/dartz.dart';
import 'package:workspace/core/error/failures.dart';

abstract class RatingRepository {
  /// يُرسل تقييم المساحة. [evaluations] = نوع المعيار -> القيمة (1..5).
  /// يُعيد رسالة النجاح من الخادم.
  Future<Either<Failure, String>> submitRating({
    required int reservationId,
    required Map<String, int> evaluations,
    required String message,
  });
}
