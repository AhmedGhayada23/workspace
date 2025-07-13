import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/dio_exceptions.dart';
import 'package:workspace/core/config/storage/remote_dio.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:dio/dio.dart' as dio;
import 'package:workspace/core/network/network_info.dart';
import 'package:workspace/features/profile/controllers/profile_controller.dart';
import 'package:path/path.dart' as path;
import 'package:workspace/features/profile/data/model/profile_data_model.dart';

class EditProfileController extends GetxController {
  Customer? customer;
  RxBool loading = false.obs;
  RxInt selectSex = 0.obs;
  RxString birthday = ''.obs;
  RxString userType = ''.obs;
  RxList<String> filepath = <String>[].obs;
  // final Customer customer = Get.arguments;

  final GlobalKey<FormState> editProfileFormKey = GlobalKey<FormState>();
  late TextEditingController aboutMeEditProfileTextEditingController;
  late TextEditingController ageEditProfileTextEditingController;
  late TextEditingController majorEditProfileTextEditingController;
  late TextEditingController universityEditProfileTextEditingController;
  late TextEditingController universityIdEditProfileTextEditingController;
  @override
  void onInit() {
    super.onInit();
    customer = Get.arguments is Customer ? Get.arguments as Customer : null;
    birthday.value = customer?.dob ?? '';
    userType.value = customer?.type ?? '';
    selectSex.value = customer?.gender == 'male' ? 1 : 0;
    if (customer?.documentsUrl != null) {
      filepath.assignAll(customer!.documentsUrl!.cast<String>());
    }

    aboutMeEditProfileTextEditingController = TextEditingController(text: customer?.aboutMe);
    ageEditProfileTextEditingController = TextEditingController(
      text: '${customer?.age != 'null' ? customer?.age : ''}',
    );
    universityEditProfileTextEditingController = TextEditingController(
      text: customer?.university ?? '',
    );
    majorEditProfileTextEditingController = TextEditingController(text: customer?.specialty);
    universityIdEditProfileTextEditingController = TextEditingController(
      text: customer?.universityNumber ?? '',
    );
  }

  // دالة للتحقق من صحة النموذج
  bool validateForm() {
    return editProfileFormKey.currentState?.validate() ?? false;
  }

  void submitEditProfile() {
    if (validateForm() && filepath.isNotEmpty) {
      editAccount();
    } else {
      // ❌ النموذج غير صحيح
      // Get.snackbar("خطأ", "يرجى التحقق من الحقول", snackPosition: SnackPosition.TOP);
    }
  }

Future<void> editAccount() async {
  loading.value = true;
  RemoteConnectionDio remoteConnectionDio = RemoteConnectionDio();

  final networkInfo = NetworkInfoImpl(Connectivity());
  final hasConnection = await networkInfo.isConnected;
  if (!hasConnection) {
    loading.value = false;
    showCustomSnackBar(Get.context!, "لا يوجد اتصال بالإنترنت", SnackBarType.noConnection);
    return;
  }

  try {
    // تجهيز الـ Map
    final Map<String, dynamic> formMap = {};

    // دالة مساعدة لإضافة الحقول غير الفارغة
    void addIfValid(String key, dynamic value) {
      if (value != null && value.toString().trim().isNotEmpty) {
        formMap[key] = value;
      }
    }

    // إضافة البيانات بشرط أنها غير null أو فارغة
    addIfValid('about_me', aboutMeEditProfileTextEditingController.text);
    addIfValid('gender', selectSex.value == 0 ? 'female' : 'male');
    addIfValid('age', ageEditProfileTextEditingController.text);
    addIfValid('dob', birthday.value);
    addIfValid('university_number', universityIdEditProfileTextEditingController.text);
    addIfValid('specialty', majorEditProfileTextEditingController.text);
    addIfValid('university', universityEditProfileTextEditingController.text);
    formMap['address'] = '--'; // ثابت دائمًا

    // الملفات
    if (filepath.isNotEmpty) {
      List<dio.MultipartFile> files = [];
      for (String filePath in filepath) {
        final file = await dio.MultipartFile.fromFile(
          filePath,
          filename: path.basename(filePath),
          contentType: dio.DioMediaType("application", "pdf"),
        );
        files.add(file);
      }
      formMap['documents[]'] = files;
    }

    // إرسال الطلب
    final formData = dio.FormData.fromMap(formMap);
    dio.Response response = await remoteConnectionDio.dio.post(
      Constants.editAccountApi,
      data: formData,
    );

    // التعامل مع النتيجة
    if (_isSuccessfulResponse(response)) {
      loading.value = false;
      Get.put(ProfileController());
      showCustomSnackBar(Get.context!, 'تم حفظ التعديلات بنجاح', SnackBarType.success);
      update();
      refresh();
    } else {
      loading.value = false;
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
    loading.value = false;
    if (e is dio.DioException) {
      final dioError = DioExceptions.fromDioError(e);
      showCustomSnackBar(Get.context!, dioError.toString(), SnackBarType.error);
    }
  } finally {
    if (Get.context!.mounted) Get.back();
    Get.put(ProfileController());
  }
}


  bool _isSuccessfulResponse(dio.Response response) {
    return response.statusCode == 200 && response.data['status'] == true;
  }

  Future<void> pickPdfFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      print('تم اختيار الملف: ${file.name}');
      print('المسار: ${file.path}');

      filepath.add(file.path.toString());
    } else {
      print('لم يتم اختيار أي ملف');
    }
  }

  @override
  void dispose() {
    editProfileFormKey.currentState?.dispose();
    aboutMeEditProfileTextEditingController.clear();
    ageEditProfileTextEditingController.clear();
    universityEditProfileTextEditingController.clear();
    universityIdEditProfileTextEditingController.clear();
    super.dispose();
  }
}
