import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/local_storage.dart';
import 'package:dio/dio.dart' as dio;
import 'package:workspace/core/config/storage/remote_dio.dart';
import 'package:workspace/features/all_space/data/models/spaces_data_model.dart' as model;

class SearchPageContrller extends GetxController with GetTickerProviderStateMixin {
  final RxBool loading = false.obs;
  final RxBool searchIsEmpty = true.obs;
  final FocusNode focusNode = FocusNode();
  late TextEditingController searchTextEditingController;
  late void Function(int) pageListener;
  final LocalStorage storage = LocalStorage();
  RxList<String> searchListHistory = <String>[].obs;
  RxList<model.Spaces> listSearchSpacesData = <model.Spaces>[].obs;
  late final AnimationController animationController;
  final PagingController<int, model.Spaces> pagingController = PagingController(firstPageKey: 1);

  Future<void> loadSearchListHistory() async {
    final list = await storage.readList('searchHistory');
    searchListHistory.assignAll(list);
  }

  Future<void> addToSearchListHistory(String value) async {
    if (value.trim().isEmpty) return;

    final updatedList = await storage.readList('searchHistory');

    // احذف القيمة إذا كانت موجودة مسبقًا لتجنب التكرار
    updatedList.removeWhere((item) => item == value.trim());

    // أضف القيمة في البداية
    updatedList.insert(0, value.trim());

    // احتفظ فقط بآخر 10 عناصر
    if (updatedList.length > 10) {
      updatedList.removeRange(10, updatedList.length);
    }

    // حفظ وتحديث القائمة
    await storage.writeList('searchHistory', updatedList);
    searchListHistory.assignAll(updatedList);
  }

  Future<void> clearHistory(int index) async {
    final removedItem = searchListHistory.removeAt(index);
    final updatedList = List<String>.from(searchListHistory);
    await storage.writeList('searchHistory', updatedList);
  }

  void refreshSearchResults() {
    pagingController.refresh();
  }

  Future<void> getSearchSpace({required int page, required String text}) async {
    loading.value = true;
    try {
      final response = await RemoteConnectionDio().dio.get(
        Constants.spacesApi,
        queryParameters: {'page': page, 'filters_search': text},
      );

      if (_isSuccessfulResponse(response)) {
        loading.value = false;
        final List<dynamic> dataNewSpace = response.data['data']['spaces'];
        final List<model.Spaces> newSpaceData =
            dataNewSpace.map((item) => model.Spaces.fromJson(item)).toList();
        listSearchSpacesData.value = newSpaceData;
        addToSearchListHistory(text);
        // final int lastPage = response.data['data']['pagination']['last_page'];

        //   final isLastPage = page >= lastPage;
        //   if (isLastPage) {
        //     loading.value = false;
        //     pagingController.appendLastPage(newSpaceData);
        //   } else {
        //     loading.value = false;
        //     final nextPageKey = page + 1;
        //     pagingController.appendPage(newSpaceData, nextPageKey);
        //   }
      } else {
        loading.value = false;
        //   pagingController.error = 'فشل في تحميل البيانات';
      }
    } catch (e) {
      loading.value = false;
      pagingController.error = e;
    } finally {
      loading.value = false;
    }
  }

  bool _isSuccessfulResponse(dio.Response response) {
    return response.statusCode == 200 && response.data['status'] == true;
  }

  @override
  void onInit() {
    super.onInit();
    loadSearchListHistory();
    searchTextEditingController = TextEditingController();
    pagingController.addPageRequestListener((pageKey) {});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
  }

  @override
  void dispose() {
    pagingController.dispose();
    searchTextEditingController.dispose();
    focusNode.dispose();
    animationController.dispose();
    super.dispose();
  }
}
