import 'package:dio/dio.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/error/exceptions.dart';
import 'package:workspace/features/Home/data/models/space_item_model.dart';
import 'package:workspace/features/all_space/domain/entities/spaces_page.dart';

abstract class AllSpacesRemoteDataSource {
  Future<SpacesPage> getSpaces({
    required int page,
    required int provinceId,
    String? profitFilter,
  });
}

class AllSpacesRemoteDataSourceImpl implements AllSpacesRemoteDataSource {
  final Dio dio;

  AllSpacesRemoteDataSourceImpl(this.dio);

  @override
  Future<SpacesPage> getSpaces({
    required int page,
    required int provinceId,
    String? profitFilter,
  }) async {
    final response = await dio.get(
      Constants.spacesApi,
      queryParameters: {
        'page': page,
        'filters_province_id': provinceId,
        'filters_profit': profitFilter,
      },
    );
    final ok = response.statusCode == 200 && response.data['status'] == true;
    if (!ok) throw const ServerException();

    final data = response.data['data'];
    final items = (data['spaces'] as List? ?? [])
        .map((e) => SpaceItemModel.fromJson(e as Map<String, dynamic>))
        .toList();
    final lastPage = (data['pagination']?['last_page'] ?? page) as int;
    return SpacesPage(items: items, isLastPage: page >= lastPage);
  }
}
