import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/dio_exceptions.dart';
import 'package:workspace/core/config/storage/remote_dio.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:workspace/features/Home/data/model/main_page_data_model.dart' as model;
import 'package:dio/dio.dart' as dio;
class VisitorHomeController extends GetxController{
  RxBool loading = true.obs;
  RxInt index = 0.obs;

  RxList<model.NewSpaces> listNewSpacesData = <model.NewSpaces>[].obs;
  RxList<model.SuggestSpaces> listsuggestSpacesData = <model.SuggestSpaces>[].obs;

  void filtersProfit(int newIndex) {
    // تحقق من أن ال index الجديد ليس هو نفس القيمة الحالية
    if (index.value != newIndex) {
      index.value = newIndex; // تغيير ال index
      getSpaces(
        newIndex == 0
            ? null
            : newIndex == 1
            ? 'non-profit'
            : 'profit',
      );
    }
  }

  Future<void> getSpaces(String? filtersProfit) async {
    loading.value = true;

    RemoteConnectionDio remoteConnectionDio = RemoteConnectionDio();

    dio.Response response = await remoteConnectionDio.dio.get(
      Constants.mainPageApi,
      queryParameters: {'filters_profit': filtersProfit},
    );

    try {
      if (_isSuccessfulResponse(response)) {
        loading.value = false;

        final dataNewSpace = response.data['data']['new_spaces'] as List<dynamic>;
         final dataSuggestSpaces = response.data['data']['suggest_spaces'] as List<dynamic>;

        final newSpaceData = dataNewSpace.map((item) => model.NewSpaces.fromJson(item)).toList();
         final suggestSpacesData =
             dataSuggestSpaces.map((item) => model.SuggestSpaces.fromJson(item)).toList();

        //   requestOrderData.addAll(newData);
        listNewSpacesData.value = newSpaceData;
        listsuggestSpacesData.value = suggestSpacesData;
        update();
      } else {
        loading.value = false;
      }
    } catch (e) {
      loading.value = false;

      if (e is dio.DioException) {
        final dioError = DioExceptions.fromDioError(e);
        showCustomSnackBar(Get.context!, dioError.toString(), SnackBarType.error);
      }
    } finally {
      loading.value = false;
    }
  }

  bool _isSuccessfulResponse(dio.Response response) {
    return response.statusCode == 200 && response.data['status'] == true;
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
  void onInit() {
    getSpaces(null);
    super.onInit();
  }
}
