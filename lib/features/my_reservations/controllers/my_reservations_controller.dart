import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/dio_exceptions.dart';
import 'package:workspace/core/config/storage/remote_dio.dart';
import 'package:workspace/core/message/message_snack_bar.dart';

import 'package:dio/dio.dart' as dio;
import 'package:workspace/features/my_reservations/data/models/order_model.dart' as model;

class MyReservationsController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  RxBool loading = true.obs;
  RxInt status = 0.obs;
  late final AnimationController animationController;
  final PagingController<int, model.Reservations> pagingController = PagingController(
    firstPageKey: 1,
  );
  RxList<model.Reservations> listvReservationsData = <model.Reservations>[].obs;

  final List<String> tabs = ['الكل', 'قيد المراجعة', 'المقبولة', 'المرفوضة'];

 Future<void> getReservations({required int page}) async {
  loading.value = true;
  try {
    final remoteConnectionDio = RemoteConnectionDio();
    final Map<String, dynamic> queryParams = {'page': page};

    if (status.value != 0) {
      queryParams['filters_status_type_id'] = status.value;
    }

    final response = await remoteConnectionDio.dio.get(
      Constants.reservationsApi,
      queryParameters: queryParams,
    );

    if (_isSuccessfulResponse(response)) {
      final List<dynamic> reservationsData = response.data['data']['reservations'];
      final List<model.Reservations> newReservationsData =
          reservationsData.map((item) => model.Reservations.fromJson(item)).toList();

      final int currentPage = response.data['data']['pagination']['current_page'];
      final int lastPage = response.data['data']['pagination']['last_page'];

      final bool isLastPage = currentPage >= lastPage;

      if (page == 1) {
        pagingController.itemList = []; // << مسح البيانات القديمة
      }

      if (isLastPage) {
        pagingController.appendLastPage(newReservationsData);
      } else {
        final nextPageKey = page + 1;
        pagingController.appendPage(newReservationsData, nextPageKey);
      }
    }
  } catch (e) {
    pagingController.error = e;
    if (e is dio.DioException) {
      final dioError = DioExceptions.fromDioError(e);
      showCustomSnackBar(Get.context!, dioError.toString(), SnackBarType.error);
    }
  } finally {
    loading.value = false;
  }
}


  Future<void> cancelReservations(int reservationId) async {
    RemoteConnectionDio remoteConnectionDio = RemoteConnectionDio();

    dio.Response response = await remoteConnectionDio.dio.post(
      Constants.concelReservationsApi,
      data: {'reservation_id': reservationId},
    );

    try {
      if (_isSuccessfulResponse(response)) {
        // تحديث حالة الحجز داخل القائمة دون حذف العنصر
        final index = listvReservationsData.indexWhere(
          (reservation) => reservation.id == reservationId,
        );
        if (index != -1) {
          // تحديث الحالة
          listvReservationsData[index].status?.id = 3;
          listvReservationsData.refresh(); // لتحديث RxList يدوياً بعد تعديل عنصر داخلها
        }

        showCustomSnackBar(Get.context!, "تم الإلغاء بنجاح", SnackBarType.success);
      } else {
        showCustomSnackBar(Get.context!, response.data['message'], SnackBarType.error);
      }
    } catch (e) {
      if (e is dio.DioException) {
        final dioError = DioExceptions.fromDioError(e);
        showCustomSnackBar(Get.context!, dioError.toString(), SnackBarType.error);
      }
    } finally {}
  }

  Future<void> reReservations(int reservationId) async {
    RemoteConnectionDio remoteConnectionDio = RemoteConnectionDio();

    dio.Response response = await remoteConnectionDio.dio.post(
      Constants.re_ReservationApi,
      data: {'reservation_id': reservationId},
    );

    try {
      if (_isSuccessfulResponse(response)) {
        // تحديث حالة الحجز داخل القائمة دون حذف العنصر
        final index = listvReservationsData.indexWhere(
          (reservation) => reservation.id == reservationId,
        );
        if (index != -1) {
          // تحديث الحالة
          listvReservationsData[index].status?.id = 1;
          listvReservationsData.refresh(); // لتحديث RxList يدوياً بعد تعديل عنصر داخلها
        }

        showCustomSnackBar(Get.context!, "تم اعادة ارسال الحجز", SnackBarType.success);
      } else {
        showCustomSnackBar(Get.context!, response.data['message'], SnackBarType.error);
      }
    } catch (e) {
      if (e is dio.DioException) {
        final dioError = DioExceptions.fromDioError(e);
        showCustomSnackBar(Get.context!, dioError.toString(), SnackBarType.error);
      }
    } finally {}
  }

  bool _isSuccessfulResponse(dio.Response response) {
    return response.statusCode == 200 && response.data['status'] == true;
  }

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      getReservations(page: pageKey);
    });
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        update(); // هذا اللي يجبر GetView تبني من جديد
      }
    });
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    super.onInit();
  }

  @override
  void onClose() {
    pagingController.dispose();
    animationController.dispose();
    super.onClose();
  }
}
