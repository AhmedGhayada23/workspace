import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/dio_exceptions.dart';
import 'package:workspace/core/config/storage/remote_dio.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:workspace/core/network/network_info.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart' as dio;
import 'package:workspace/features/profile/controllers/profile_controller.dart';

class SettingProfileController extends GetxController {
  RxBool loading = false.obs;
  RxString types = (Get.parameters['type'] ?? '').obs;
  RxString typeTitle = (Get.parameters['userType'] ?? '').obs;

  final ImagePicker _picker = ImagePicker();
  Rx<File?> imageFile = Rx<File?>(null);
  final FocusNode nextFieldFocus = FocusNode();

  final GlobalKey<FormState> settingProfileFormKey = GlobalKey<FormState>();
  late TextEditingController fullNameSettingProfileTextEditingController;
  late TextEditingController phoneSettingProfileTextEditingController;
  late TextEditingController emailSettingProfileTextEditingController;

  final Map<String, String> userTypes = {
    'طالب': 'student',
    'موظف': 'employee',
    'مستقل': 'independent',
    'شركة': 'company',
  };
  @override
  void onInit() {
    super.onInit();

    fullNameSettingProfileTextEditingController = TextEditingController(
      text: Get.parameters['name'] ?? '',
    );
    phoneSettingProfileTextEditingController = TextEditingController(
      text: Get.parameters['mobile'] ?? '',
    );
    emailSettingProfileTextEditingController = TextEditingController(
      text: Get.parameters['email'] ?? '',
    );
  }

  // دالة للتحقق من صحة النموذج
  bool validateForm() {
    return settingProfileFormKey.currentState?.validate() ?? false;
  }

  void submitSettingProfile() {
    if (validateForm()) {
      editSettingAccount();
    } else {
      // ❌ النموذج غير صحيح
      // Get.snackbar("خطأ", "يرجى التحقق من الحقول", snackPosition: SnackPosition.TOP);
    }
  }

  Future<void> editSettingAccount() async {
    loading.value = true;
    RemoteConnectionDio remoteConnectionDio = RemoteConnectionDio();

    final networkInfo = NetworkInfoImpl(Connectivity());
    final hasConnection = await networkInfo.isConnected;
    if (!hasConnection) {
      loading.value = false;
      showCustomSnackBar(Get.context!, "لا يوجد اتصال بالإنترنت", SnackBarType.noConnection);
      return; // لازم توقف هنا
    }

    try {
      // تجهيز البيانات
      final Map<String, dynamic> formDataMap = {
        'name': fullNameSettingProfileTextEditingController.text.trim(),
        'type': types.value,
        'email': emailSettingProfileTextEditingController.text.trim(),
        'mobile': phoneSettingProfileTextEditingController.text.trim(),
      };

      // إضافة الصورة إن وُجدت
      if (imageFile.value != null) {
        final file = await dio.MultipartFile.fromFile(
          imageFile.value!.path,
          filename: path.basename(imageFile.value!.path),
        );
        formDataMap['image'] = file; // أو 'avatar' حسب اسم المفتاح المطلوب في الـ API
      }

      final formData = dio.FormData.fromMap(formDataMap);
      dio.Response response = await remoteConnectionDio.dio.post(
        Constants.settingAccountApi,
        data: formData,
      );

      if (_isSuccessfulResponse(response)) {
        update();
        loading.value = false;

        showCustomSnackBar(Get.context!, 'تم حفظ التعديلات بنجاح', SnackBarType.success);
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
    }finally{
      if(Get.context!.mounted)
      Get.put(ProfileController());
    }
  }

  bool _isSuccessfulResponse(dio.Response response) {
    return response.statusCode == 200 && response.data['status'] == true;
  }

  Future<void> pickFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      Navigator.pop(Get.context!);
    }
  }

  Future<void> pickFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Navigator.pop(Get.context!);
      imageFile.value = File(pickedFile.path);
    }
  }

  void deleteImage() {
    imageFile.value = null;
  }

  void showTakePhoto(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // يخلي المستخدم ما يقدر يقفل البوب أب إلا بزر
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          backgroundColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'تغيير الصورة', // استبدله بالنص الذي تريده
                  textAlign: TextAlign.center,
                  style: GoogleFonts.tajawal(
                    color: Color(0xFF212121), // اللون من المتغير B-1
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700, // Bold
                    fontStyle: FontStyle.normal,
                    height: 1.0, // line-height: normal
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () => pickFromCamera(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppSvg.cameraSvg,
                        width: 17.w,
                        height: 17.h,
                        color: AppColors.black,
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        'اخذ صورة', // استبدل بالنص الذي تريده
                        textAlign: TextAlign.right,
                        style: GoogleFonts.tajawal(
                          color: Color(0xFF212121), // اللون Grayscale-900
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500, // Medium
                          fontStyle: FontStyle.normal,
                          height: 1.0, // line-height: normal
                        ),
                      ),
                      Container(),
                    ],
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () => pickFromGallery(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppSvg.folderOpenSvg,
                        width: 17.w,
                        height: 17.h,
                        color: AppColors.black,
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        'اختر من الاستديو', // استبدل بالنص الذي تريده
                        textAlign: TextAlign.right,
                        style: GoogleFonts.tajawal(
                          color: Color(0xFF212121), // اللون Grayscale-900
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500, // Medium
                          fontStyle: FontStyle.normal,
                          height: 1.0, // line-height: normal
                        ),
                      ),
                      Container(),
                    ],
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () => deleteImage(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppSvg.trashSvg,
                        width: 17.w,
                        height: 17.h,
                        color: Color(0xFFF75555),
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        'حذف الصورة', // استبدل بالنص الذي تريده
                        textAlign: TextAlign.right,
                        style: GoogleFonts.tajawal(
                          color: Color(0xFFF75555), // اللون Grayscale-900
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500, // Medium
                          fontStyle: FontStyle.normal,
                          height: 1.0, // line-height: normal
                        ),
                      ),
                      Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    settingProfileFormKey.currentState?.dispose();
    fullNameSettingProfileTextEditingController.clear();
    phoneSettingProfileTextEditingController.clear();
    emailSettingProfileTextEditingController.clear();
    super.dispose();
  }
}
