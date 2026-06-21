import 'package:dio/dio.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/error/exceptions.dart';
import 'package:workspace/features/my_reservations/data/models/details_resevation_model.dart';
import 'package:workspace/features/my_reservations/data/models/order_model.dart';
import 'package:workspace/features/my_reservations/domain/entities/reservations_page.dart';

abstract class ReservationsRemoteDataSource {
  Future<ReservationsPage> getReservations({required int page, required int statusTypeId});
  Future<void> cancel(int reservationId);
  Future<void> reReserve(int reservationId);
  Future<DetailsResevationModel> getDetails(int reservationId);
}

class ReservationsRemoteDataSourceImpl implements ReservationsRemoteDataSource {
  final Dio dio;

  ReservationsRemoteDataSourceImpl(this.dio);

  @override
  Future<ReservationsPage> getReservations({required int page, required int statusTypeId}) async {
    final query = <String, dynamic>{'page': page};
    if (statusTypeId != 0) query['filters_status_type_id'] = statusTypeId;

    final response = await dio.get(Constants.reservationsApi, queryParameters: query);
    _ensureSuccess(response);

    final data = response.data['data'];
    final items = (data['reservations'] as List? ?? [])
        .map((e) => Reservations.fromJson(e as Map<String, dynamic>))
        .toList();
    final current = (data['pagination']?['current_page'] ?? page) as int;
    final last = (data['pagination']?['last_page'] ?? page) as int;
    return ReservationsPage(items: items, isLastPage: current >= last);
  }

  @override
  Future<void> cancel(int reservationId) async {
    final response = await dio.post(
      Constants.concelReservationsApi,
      data: {'reservation_id': reservationId},
    );
    _ensureSuccess(response);
  }

  @override
  Future<void> reReserve(int reservationId) async {
    final response = await dio.post(
      Constants.re_ReservationApi,
      data: {'reservation_id': reservationId},
    );
    _ensureSuccess(response);
  }

  @override
  Future<DetailsResevationModel> getDetails(int reservationId) async {
    final response = await dio.get('${Constants.reservationsApi}/$reservationId');
    _ensureSuccess(response);
    return DetailsResevationModel.fromJson(response.data as Map<String, dynamic>);
  }

  void _ensureSuccess(Response response) {
    final ok = response.statusCode == 200 && response.data['status'] == true;
    if (!ok) throw ServerException(_extractMessage(response.data));
  }

  String _extractMessage(dynamic data) {
    final message = (data is Map) ? data['message'] : null;
    if (message is String) return message;
    if (message is List) return message.join('\n');
    if (message is Map) {
      return message.entries
          .map((e) => e.value is List ? (e.value as List).join('\n') : e.value.toString())
          .join('\n');
    }
    return 'حدث خطأ غير متوقع';
  }
}
