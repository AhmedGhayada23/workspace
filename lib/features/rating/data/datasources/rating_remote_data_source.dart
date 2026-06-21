import 'package:dio/dio.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/error/exceptions.dart';

abstract class RatingRemoteDataSource {
  Future<String> submitRating({
    required int reservationId,
    required Map<String, int> evaluations,
    required String message,
  });
}

class RatingRemoteDataSourceImpl implements RatingRemoteDataSource {
  final Dio dio;

  RatingRemoteDataSourceImpl(this.dio);

  @override
  Future<String> submitRating({
    required int reservationId,
    required Map<String, int> evaluations,
    required String message,
  }) async {
    final response = await dio.post(
      Constants.ratingApi,
      data: {
        'evaluations': [
          for (final e in evaluations.entries) {'type': e.key, 'value': e.value.toString()},
        ],
        'message': message,
        'reservation_id': reservationId,
      },
    );
    if (!_ok(response)) throw ServerException(_message(response.data));
    return _message(response.data);
  }

  bool _ok(Response response) =>
      response.statusCode == 200 && response.data['status'] == true;

  String _message(dynamic data) {
    final message = (data is Map) ? data['message'] : null;
    if (message is Map) {
      return message.entries
          .map((e) => e.value is List ? (e.value as List).join('\n') : e.value.toString())
          .join('\n');
    } else if (message is List) {
      return message.join('\n');
    } else if (message is String) {
      return message;
    }
    return 'شكرا على تقييمك';
  }
}
