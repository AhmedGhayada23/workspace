import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/dio_exceptions.dart';
import 'package:workspace/core/config/storage/remote_dio.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:dio/dio.dart' as dio;
import 'package:workspace/core/network/network_info.dart';
import 'package:workspace/core/widgets/booking_success_popup_widget.dart';
import 'package:workspace/features/details_space/data/model/details_space_model.dart';
import 'package:workspace/features/Home/data/model/main_page_data_model.dart' as modelSpace;

class DetailsSpaceController extends GetxController with GetTickerProviderStateMixin {
  RxBool loading = true.obs;
  RxBool loadingSpace = true.obs;
  RxBool loadingNonProfit = false.obs;

  RxBool showTypeBooking = false.obs;
  RxInt idTypeBooking = 2.obs;

  late TabController tabController;
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  final List<String> tabs = ['التفاصيل', 'الصور', 'الاشتراكات', 'التقييمات'];
  Rxn<DetailsSpaceModel> listDetailsSpacesData = Rxn<DetailsSpaceModel>();
  RxList<modelSpace.SuggestSpaces> listsuggestSpacesData = <modelSpace.SuggestSpaces>[].obs;

  @override
  void onInit() {
        super.onInit();
    showTypeBooking.value = false;
    getDetailsSpaces();
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        update();
      }
    });
  }

  Future<void> getDetailsSpaces() async {
    loading.value = true;

    try {
      RemoteConnectionDio remoteConnectionDio = RemoteConnectionDio();
      final response = await remoteConnectionDio.dio.get('${Constants.spacesApi}/${Get.arguments}');

      if (_isSuccessfulResponse(response)) {
        listDetailsSpacesData.value = DetailsSpaceModel.fromJson(response.data);

        final videoUrl = listDetailsSpacesData.value?.data?.spaces?.videoUrl;
        if (videoUrl != null && videoUrl.isNotEmpty) {
          await _initializeVideo(videoUrl);
        }
      }
    } catch (e) {
      if (e is dio.DioException) {
        final dioError = DioExceptions.fromDioError(e);
        showCustomSnackBar(Get.context!, dioError.toString(), SnackBarType.error);
      }
    } finally {
      loading.value = false;
    }

    // في حال الخطأ أو البيانات فارغة
  }

  Future<void> getSpaces(String? filtersProfit) async {
    loadingSpace.value = true;

    RemoteConnectionDio remoteConnectionDio = RemoteConnectionDio();

    dio.Response response = await remoteConnectionDio.dio.get(Constants.mainPageApi);

    try {
      if (_isSuccessfulResponse(response)) {
        loadingSpace.value = false;
        final dataSuggestSpaces = response.data['data']['suggest_spaces'] as List<dynamic>;

        final suggestSpacesData =
            dataSuggestSpaces.map((item) => modelSpace.SuggestSpaces.fromJson(item)).toList();
        listsuggestSpacesData.value = suggestSpacesData;
        update();
      } else {
        loadingSpace.value = false;
      }
    } catch (e) {
      loadingSpace.value = false;

      if (e is dio.DioException) {
        final dioError = DioExceptions.fromDioError(e);
        showCustomSnackBar(Get.context!, dioError.toString(), SnackBarType.error);
      }
    } finally {
      loadingSpace.value = false;
    }
  }

  Future<void> confirmBookingNonProfit(int spaceId) async {
    log('message');
    loadingNonProfit.value = true;
    RemoteConnectionDio remoteConnectionDio = RemoteConnectionDio();

    final networkInfo = NetworkInfoImpl(Connectivity());
    final hasConnection = await networkInfo.isConnected;
    if (!hasConnection) {
      log('mess');
      loadingNonProfit.value = false;
      showCustomSnackBar(Get.context!, "لا يوجد اتصال بالإنترنت", SnackBarType.noConnection);
      return; // لازم توقف هنا
    }
    log('messs');
    try {
      log('messssss');
      dio.Response response = await remoteConnectionDio.dio.post(
        Constants.reservationsApi,
        data: {'space_id': spaceId},
      );
      log('messssssa');
      if (_isSuccessfulResponse(response)) {
        loadingNonProfit.value = false;

        showBookingSuccessPopup();
      } else {
        loadingNonProfit.value = false;
        final message = response.data['message'];
        String messageText = "حدث خطأ غير متوقع";

        if (message is Map) {
          messageText = message.entries
              .map((entry) => entry.value is List ? entry.value.join("\n") : entry.value.toString())
              .join("\n");
          showCustomSnackBar(Get.context!, messageText, SnackBarType.error);
        } else if (message is List) {
          messageText = message.join("\n");
          showCustomSnackBar(Get.context!, messageText, SnackBarType.error);
        } else if (message is String) {
          messageText = message;
          showCustomSnackBar(Get.context!, messageText, SnackBarType.error);
        }
      }
    } catch (e) {
      loadingNonProfit.value = false;
      if (e is dio.DioException) {
        final dioError = DioExceptions.fromDioError(e);
        showCustomSnackBar(Get.context!, dioError.toString(), SnackBarType.error);
      }
    }
  }

  void showBookingSuccessPopup() {
    showDialog(context: Get.context!, builder: (_) => const BookingSuccessPopup());
  }

  bool _isSuccessfulResponse(dio.Response response) {
    return response.statusCode == 200 && response.data['status'] == true;
  }

  Future<void> _initializeVideo(String url) async {
    try {
      videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(url),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );

      await videoPlayerController.initialize();

      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        aspectRatio: videoPlayerController.value.aspectRatio,
        autoPlay: true,
        looping: true,
      );

      update();
    } catch (e) {
      print("فشل تحميل الفيديو: $e");
    }
  }

  String formatTime(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty) return '---';

    try {
      // نحول am/pm إلى AM/PM
      timeStr = timeStr.toUpperCase();

      final inputFormat = DateFormat('hh:mm a');
      final dateTime = inputFormat.parse(timeStr);

      final formatted = DateFormat('hh:mm a').format(dateTime);

      // نحول AM/PM إلى صباحًا/مساءً
      return formatted.contains('AM')
          ? formatted.replaceAll('AM', 'صباحًا')
          : formatted.replaceAll('PM', 'مساءً');
    } catch (e) {
      print("Error parsing time: $e");
      return '---';
    }
  }

  @override
  void dispose() {
    log('message dispose');

    tabController.dispose();
    showTypeBooking.value = false;
    idTypeBooking.value = 2;
    videoPlayerController.dispose();
    chewieController?.dispose();

    super.dispose();
  }

  @override
  void onClose() {
    log('message close');
    videoPlayerController.dispose();
    chewieController?.dispose();
    showTypeBooking.value = false;

    super.onClose();
  }
}
