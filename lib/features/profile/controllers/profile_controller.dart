import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/dio_exceptions.dart';
import 'package:workspace/core/config/storage/local_storage.dart';
import 'package:workspace/core/config/storage/remote_dio.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:workspace/core/network/network_info.dart';
import 'package:workspace/core/network/network_manager.dart';
import 'package:workspace/features/profile/data/model/profile_data_model.dart' as model;
import 'package:workspace/utils/routing.dart';

class ProfileController extends GetxController {
  RxBool loading = true.obs;
  Rxn<model.ProfileDataModel> listProileData = Rxn<model.ProfileDataModel>();

  Future<void> getProfileData() async {
    final token = LocalStorage().readValue<String>(Constants.token);
    if (token == null || token.isEmpty) {
      loading.value = false;
      listProileData.value = null;
      // لا يوجد توكن، لا تنفذ الطلب
      return;
    }
    loading.value = true;



    try {
      RemoteConnectionDio connectionDio = RemoteConnectionDio();
      dio.Response response = await connectionDio.dio.get(Constants.profileMeApi);
      if (_isSuccessfulResponse(response)) {
        loading.value = false;
        listProileData.value = model.ProfileDataModel.fromJson(response.data);
      } else {
        loading.value = false;
        listProileData.value!.data = null;
      }
    } catch (e) {
      loading.value = false;

      if (e is dio.DioException) {
        final dioError = DioExceptions.fromDioError(e);
        showCustomSnackBar(Get.context!, dioError.toString(), SnackBarType.error);
      }
    }
  }

  Future<void> logoutAccount() async {
    final networkInfo = NetworkInfoImpl(Connectivity());
    final hasConnection = await networkInfo.isConnected;
    if (!hasConnection) {
      showCustomSnackBar(Get.context!, "لا يوجد اتصال بالإنترنت", SnackBarType.noConnection);
      return; // لازم توقف هنا
    }

    try {
      final remoteConnectionDio = RemoteConnectionDio();
      final response = await remoteConnectionDio.dio.post(Constants.logoutApi);

      if (_isSuccessfulResponse(response)) {
        logoutRemoveData();

        Get.offAllNamed(AppRouting.signInView);
      } else {
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
      if (e is dio.DioException) {
        final dioError = DioExceptions.fromDioError(e);
        showCustomSnackBar(Get.context!, dioError.toString(), SnackBarType.error);
      }
    }
  }

  bool _isSuccessfulResponse(dio.Response response) {
    return response.statusCode == 200 && response.data['status'] == true;
  }

  void logoutRemoveData() {
    LocalStorage().removeKey(Constants.token);
  }

  @override
  void onInit() {
    getProfileData();
    NetworkManager().initListener(
      onConnected: () {
        getProfileData();
      },
    );
    super.onInit();
  }
}
