import 'package:dio/dio.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/error/exceptions.dart';
import 'package:workspace/features/search/domain/entities/search_result.dart';

abstract class SearchRemoteDataSource {
  Future<List<SearchResultItem>> search(String text);
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final Dio dio;

  SearchRemoteDataSourceImpl(this.dio);

  @override
  Future<List<SearchResultItem>> search(String text) async {
    final response = await dio.get(
      Constants.spacesApi,
      queryParameters: {'page': 1, 'filters_search': text},
    );
    final ok = response.statusCode == 200 && response.data['status'] == true;
    if (!ok) throw const ServerException();

    final list = (response.data['data']['spaces'] as List? ?? []);
    return list.map((e) {
      final map = e as Map<String, dynamic>;
      final company = map['company'] is Map ? map['company'] as Map : const {};
      final province = map['province'] is Map ? map['province'] as Map : const {};
      return SearchResultItem(
        id: map['id'] is int ? map['id'] as int : 0,
        companyName: (company['name'] ?? '').toString(),
        provinceName: (province['name'] ?? '').toString(),
      );
    }).toList();
  }
}
