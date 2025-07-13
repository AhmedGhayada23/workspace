import 'dart:developer';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/dio_exceptions.dart';
import 'package:workspace/core/config/storage/local_storage.dart';
import 'package:workspace/core/config/storage/remote_dio.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:workspace/features/notification/controllers/fcm_notification_controller.dart';
import 'package:workspace/features/notification/data/model/notification_model.dart' as model;
import 'package:dio/dio.dart' as dio;

class NotifcationController extends GetxController {
  RxBool loading = true.obs;
  final hasUnread = false.obs;



  final PagingController<int, model.Notifications> pagingController = PagingController(
    firstPageKey: 1,
  );

  RxList<model.Notifications> listvReservationsData = <model.Notifications>[].obs;

  Future<void> getNotifications({required int page}) async {
    final token = LocalStorage().readValue<String>(Constants.token);
    if (token == null || token.isEmpty) {
      loading.value = false;
      pagingController.appendLastPage([]);

      // لا يوجد توكن، لا تنفذ الطلب
      return;
    }
    loading.value = true;
    try {
      final remoteConnectionDio = RemoteConnectionDio();
      final Map<String, dynamic> queryParams = {'page': page};

      final response = await remoteConnectionDio.dio.get(
        Constants.notificationsApi,
        queryParameters: queryParams,
      );

      if (_isSuccessfulResponse(response)) {
        loading.value = false;
        final List<dynamic> reservationsData = response.data['data']['notifications'];
        final List<model.Notifications> newReservationsData =
            reservationsData.map((item) => model.Notifications.fromJson(item)).toList();

        final int currentPage = response.data['data']['pagination']['current_page'];
        final int lastPage = response.data['data']['pagination']['last_page'];

        final bool isLastPage = currentPage >= lastPage;

        if (page == 1) {
          loading.value = false;

          pagingController.itemList = []; // << مسح البيانات القديمة
        }

        if (isLastPage) {
          loading.value = false;

          pagingController.appendLastPage(newReservationsData);

          updateHasUnread();
        } else {
          loading.value = false;

          final nextPageKey = page + 1;
          pagingController.appendPage(newReservationsData, nextPageKey);
          updateHasUnread();
        }
      }
    } catch (e) {
      loading.value = false;

      pagingController.error = e;
      if (e is dio.DioException) {
        final dioError = DioExceptions.fromDioError(e);
        showCustomSnackBar(Get.context!, dioError.toString(), SnackBarType.error);
      }
    } finally {
      loading.value = false;
    }
  }

  void updateHasUnread() {
    hasUnread.value = pagingController.itemList?.any((item) => item.readAt == null) ?? false;
  }

  Future<void> readNotifications() async {
    try {
      final remoteConnectionDio = RemoteConnectionDio();

      final response = await remoteConnectionDio.dio.post(Constants.readNotificationsApi);

      if (_isSuccessfulResponse(response)) {
        hasUnread.value = false;
        final fcmController = Get.put(FcmNotificationController());
        fcmController.clearUnread();

      } else {
        log('ssssssssssssssssssssssssss');
      }
    } catch (e) {
      pagingController.error = e;
      if (e is dio.DioException) {
        final dioError = DioExceptions.fromDioError(e);
        showCustomSnackBar(Get.context!, dioError.toString(), SnackBarType.error);
      }
    } finally {}
  }

  bool _isSuccessfulResponse(dio.Response response) {
    return response.statusCode == 200 && response.data['status'] == true;
  }




String timeAgo(String dateTimeString) {
  try {
    // تأكد من أن AM/PM مكتوبة بشكل صحيح
    dateTimeString = dateTimeString.replaceAll(RegExp(r' am$', caseSensitive: false), ' AM');
    dateTimeString = dateTimeString.replaceAll(RegExp(r' pm$', caseSensitive: false), ' PM');

    print('Parsing date string: $dateTimeString');

    // تحليل التاريخ ثم تحويله للتوقيت المحلي
    DateTime dateTime = DateFormat("yyyy-MM-dd hh:mm:ss a").parse(dateTimeString).toLocal();

    Duration diff = DateTime.now().difference(dateTime);

    if (diff.inSeconds < 0) return 'الآن'; // حماية في حال المستقبل

    if (diff.inSeconds < 60) {
      return 'قبل ${diff.inSeconds} ثانية';
    } else if (diff.inMinutes < 60) {
      return 'قبل ${diff.inMinutes} دقيقة';
    } else if (diff.inHours < 24) {
      return 'قبل ${diff.inHours} ساعة';
    } else if (diff.inDays < 7) {
      return 'قبل ${diff.inDays} يوم';
    } else if (diff.inDays < 30) {
      int weeks = (diff.inDays / 7).floor();
      return 'قبل $weeks أسبوع';
    } else if (diff.inDays < 365) {
      int months = (diff.inDays / 30).floor();
      return 'قبل $months شهر';
    } else {
      int years = (diff.inDays / 365).floor();
      return 'قبل $years سنة';
    }
  } catch (e) {
    print('Error parsing date: $e');
    return 'تاريخ غير صالح';
  }
}




  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      getNotifications(page: pageKey);
    });
  }
}
