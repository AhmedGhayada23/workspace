import 'package:dio/dio.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/error/exceptions.dart';

abstract class BookingRemoteDataSource {
  Future<void> confirmProfit({
    required String spaceId,
    required String subscriptionId,
    required String startDate,
    required String endDate,
    required String startTime,
    required String endTime,
    required String seatsCount,
  });
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final Dio dio;

  BookingRemoteDataSourceImpl(this.dio);

  @override
  Future<void> confirmProfit({
    required String spaceId,
    required String subscriptionId,
    required String startDate,
    required String endDate,
    required String startTime,
    required String endTime,
    required String seatsCount,
  }) async {
    final response = await dio.post(
      Constants.reservationsApi,
      data: {
        'space_id': spaceId,
        'is_profit': 'true',
        'subscription_id': subscriptionId,
        'start_date': startDate,
        'end_date': endDate,
        'start_time': startTime,
        'end_time': endTime,
        'seats_count': seatsCount,
      },
    );
    final ok = response.statusCode == 200 && response.data['status'] == true;
    if (ok) return;
    throw ServerException(_extractMessage(response.data));
  }

  String _extractMessage(dynamic data) {
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
    return 'حدث خطأ غير متوقع';
  }
}
