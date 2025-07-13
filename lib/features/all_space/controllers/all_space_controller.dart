import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/dio_exceptions.dart';
import 'package:workspace/core/config/storage/remote_dio.dart';
import 'package:workspace/core/message/message_snack_bar.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/features/all_space/data/models/spaces_data_model.dart' as model;
import 'package:workspace/features/notification/controllers/fcm_notification_controller.dart';
import 'package:workspace/features/profile/controllers/profile_controller.dart';
import 'package:dio/dio.dart' as dio;

class AllSpaceController extends GetxController with GetTickerProviderStateMixin {
  RxBool loading = true.obs;
  RxInt index = 0.obs;
  RxInt selectedRudi = 0.obs;
  final profileData = Get.put(ProfileController());
  late final AnimationController animationController;

  final fcmController = Get.put(FcmNotificationController());

  RxList<model.Spaces> listSpacesData = <model.Spaces>[].obs;
  final PagingController<int, model.Spaces> pagingController = PagingController(firstPageKey: 1);
  final Map<String, String> rudisList = {
    'الكل': '0',
    'شمال': '1',
    'رفح': '2',
    'المغازي': '3',
    'الدير البلح': '4',
    'غزة': '5',
    'خانيونس': '6',
  };

  void filtersProfit(int newIndex) {
    // تحقق من أن ال index الجديد ليس هو نفس القيمة الحالية
    if (index.value != newIndex) {
      index.value = newIndex; // تغيير ال index
      pagingController.refresh();
    }
  }

  Future<void> getSpaces({required int page}) async {
    loading.value = true;

    try {
      RemoteConnectionDio remoteConnectionDio = RemoteConnectionDio();
      final response = await remoteConnectionDio.dio.get(
        Constants.spacesApi,
        queryParameters: {
          'page': page,
          'filters_province_id': selectedRudi.value,
          'filters_profit':
              index.value == 0
                  ? null
                  : index.value == 1
                  ? 'non-profit'
                  : 'profit',
        },
      );

      if (_isSuccessfulResponse(response)) {
        final List<dynamic> dataNewSpace = response.data['data']['spaces'];
        final List<model.Spaces> spaceData =
            dataNewSpace.map((item) => model.Spaces.fromJson(item)).toList();

        final bool isLastPage =
            spaceData.length <
            response.data['data']['pagination']['last_page']; // عدل الرقم حسب عدد العناصر في الصفحة
        if (isLastPage) {
          pagingController.appendLastPage(spaceData);
        } else {
          final nextPageKey = page + 1;
          pagingController.appendPage(spaceData, nextPageKey);
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

    // في حال الخطأ أو البيانات فارغة
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

  void showFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
      backgroundColor: const Color(0xFFFAFAFA),
      isScrollControlled: false,
      builder: (BuildContext context) {
        final keys = rudisList.keys.toList();

        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInUp(
                child: Text(
                  'تصفية',
                  style: GoogleFonts.tajawal(
                    color: const Color(0xFF616161),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                height: 300.h, // أو حسب ما يناسبك
                child: ListView.builder(
                  itemCount: keys.length,
                  itemBuilder: (context, index) {
                    final rudi = keys[index];
                    return InkWell(
                      onTap: () {
                        selectedRudi.value = index;
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 16.h),
                        child: FadeInUp(
                          child: Row(
                            children: [
                              Obx(
                                () => Container(
                                  width: 24.w,
                                  height: 24.h,
                                  padding: EdgeInsets.all(2.r),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 3,
                                      color:
                                          selectedRudi.value == index
                                              ? const Color(0xFF32B599)
                                              : const Color(0xFFD6F0EB),
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child:
                                      selectedRudi.value == index
                                          ? Container(
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF32B599),
                                              shape: BoxShape.circle,
                                            ),
                                          )
                                          : null,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                rudi,
                                style: GoogleFonts.tajawal(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF000000),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              BounceInDown(
                child: InkWell(
                  onTap: () {
                    final selectedKey = keys[selectedRudi.value];
                    final selectedValue = rudisList[selectedKey];
                    selectedRudi.value = int.parse(selectedValue!);

                    // ✅ نفذ الفلترة هنا حسب selectedValue
                    print('الفلترة حسب: $selectedKey (ID: $selectedValue)');
                    pagingController.refresh();
                    // يمكنك استدعاء دالة لجلب أو فلترة البيانات بناءً على selectedValue
                    // مثلا:
                    // controller.filterByRegion(selectedValue);

                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 44.h,
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF32B599),
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppSvg.settingSvg, width: 24.w, height: 24.h),
                        SizedBox(width: 8.w),
                        Text(
                          'تصفية الان',
                          style: GoogleFonts.tajawal(
                            color: const Color(0xFFFAFAFA),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            height: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    // pagingController = PagingController<int, model.Spaces>(
    //   getNextPageKey: (state) {
    //     final nextKey = (state.keys?.last ?? 0) + 1;
    //     return nextKey;
    //   },
    //   fetchPage: (pageKey) async {
    //     final newItems = await getSpaces();
    //     return newItems;
    //   },
    // );
    pagingController.addPageRequestListener((pageKey) {
      getSpaces(page: pageKey);
    });
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
  }

  @override
  void onClose() {
    pagingController.dispose();
    animationController.dispose();
    super.onClose();
  }
}
