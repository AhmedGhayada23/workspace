import 'package:dio/dio.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/error/exceptions.dart';
import 'package:workspace/features/notification/data/model/notification_model.dart';
import 'package:workspace/features/notification/domain/entities/notifications_page.dart';

abstract class NotificationsRemoteDataSource {
  Future<NotificationsPage> getNotifications(int page);
  Future<void> markAllAsRead();
}

class NotificationsRemoteDataSourceImpl implements NotificationsRemoteDataSource {
  final Dio dio;

  NotificationsRemoteDataSourceImpl(this.dio);

  @override
  Future<NotificationsPage> getNotifications(int page) async {
    final response = await dio.get(
      Constants.notificationsApi,
      queryParameters: {'page': page},
    );
    _ensureSuccess(response);

    final data = response.data['data'];
    final items = (data['notifications'] as List? ?? [])
        .map((e) => Notifications.fromJson(e as Map<String, dynamic>))
        .toList();
    final current = (data['pagination']?['current_page'] ?? page) as int;
    final last = (data['pagination']?['last_page'] ?? page) as int;
    return NotificationsPage(items: items, isLastPage: current >= last);
  }

  @override
  Future<void> markAllAsRead() async {
    final response = await dio.post(Constants.readNotificationsApi);
    _ensureSuccess(response);
  }

  void _ensureSuccess(Response response) {
    final ok = response.statusCode == 200 && response.data['status'] == true;
    if (!ok) throw ServerException(_extractMessage(response.data));
  }

  String _extractMessage(dynamic data) {
    final message = (data is Map) ? data['message'] : null;
    if (message is String) return message;
    if (message is List) return message.join('\n');
    return 'حدث خطأ غير متوقع';
  }
}
