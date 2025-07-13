import 'package:get/get.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/dio_exceptions.dart';
import 'package:workspace/core/config/storage/remote_dio.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:dio/dio.dart' as dio;
import 'package:workspace/features/my_reservations/data/models/details_resevation_model.dart';
import 'package:workspace/features/my_reservations/data/models/order_model.dart';


class DetailsMyResevationController extends GetxController {
  RxBool loading = true.obs;
  Reservations reservations = Get.arguments;

  Rxn<DetailsResevationModel> dataReservationDetatials = Rxn<DetailsResevationModel>();

  Future<void> getReservationDetatials() async {
    loading.value = true;

    try {
      RemoteConnectionDio connectionDio = RemoteConnectionDio();
      dio.Response response = await connectionDio.dio.get(
        '${Constants.reservationsApi}/${reservations.id}',
      );
      if (_isSuccessfulResponse(response)) {
        loading.value = false;
        dataReservationDetatials.value = DetailsResevationModel.fromJson(response.data);
      } else {
        loading.value = false;
        dataReservationDetatials.value!.data = null;
      }
    } catch (e) {
      loading.value = false;

      if (e is dio.DioException) {
        final dioError = DioExceptions.fromDioError(e);
        showCustomSnackBar(Get.context!, dioError.toString(), SnackBarType.error);
      }
    }
  }

  bool _isSuccessfulResponse(dio.Response response) {
    return response.statusCode == 200 && response.data['status'] == true;
  }

  @override
  void onInit() {
    getReservationDetatials();
    super.onInit();
  }
}
