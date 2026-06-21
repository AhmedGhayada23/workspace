import 'package:dio/dio.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/error/exceptions.dart';
import 'package:workspace/features/Home/data/models/home_profile_model.dart';
import 'package:workspace/features/Home/data/models/space_item_model.dart';
import 'package:workspace/features/Home/domain/entities/main_page.dart';

abstract class HomeRemoteDataSource {
  Future<MainPage> getMainPage(String? filterProfit);
  Future<HomeProfileModel> getProfileHeader();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSourceImpl(this.dio);

  @override
  Future<MainPage> getMainPage(String? filterProfit) async {
    final response = await dio.get(
      Constants.mainPageApi,
      queryParameters: {'filters_profit': filterProfit},
    );
    _ensureSuccess(response);
    final data = response.data['data'] as Map<String, dynamic>;
    final newSpaces = (data['new_spaces'] as List? ?? [])
        .map((e) => SpaceItemModel.fromJson(e as Map<String, dynamic>))
        .toList();
    final suggestSpaces = (data['suggest_spaces'] as List? ?? [])
        .map((e) => SpaceItemModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return MainPage(newSpaces: newSpaces, suggestSpaces: suggestSpaces);
  }

  @override
  Future<HomeProfileModel> getProfileHeader() async {
    final response = await dio.get(Constants.profileMeApi);
    _ensureSuccess(response);
    return HomeProfileModel.fromResponse(response.data as Map<String, dynamic>);
  }

  void _ensureSuccess(Response response) {
    final ok = response.statusCode == 200 && response.data['status'] == true;
    if (!ok) throw const ServerException();
  }
}
