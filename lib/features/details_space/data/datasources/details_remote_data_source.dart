import 'package:dio/dio.dart';
import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/error/exceptions.dart';
import 'package:workspace/features/details_space/data/model/details_space_model.dart';

abstract class DetailsRemoteDataSource {
  Future<DetailsSpaceModel> getDetails(int id);
  Future<void> bookNonProfit(int spaceId);
}

class DetailsRemoteDataSourceImpl implements DetailsRemoteDataSource {
  final Dio dio;

  DetailsRemoteDataSourceImpl(this.dio);

  @override
  Future<DetailsSpaceModel> getDetails(int id) async {
    final response = await dio.get('${Constants.spacesApi}/$id');
    final ok = response.statusCode == 200 && response.data['status'] == true;
    if (!ok) throw const ServerException();
    return DetailsSpaceModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> bookNonProfit(int spaceId) async {
    final response = await dio.post(
      Constants.reservationsApi,
      data: {'space_id': spaceId},
    );
    final ok = response.statusCode == 200 && response.data['status'] == true;
    if (ok) return;
    throw ServerException(_extractMessage(response.data));
  }

  String _extractMessage(dynamic data) {
    final message = (data is Map) ? data['message'] : null;
    if (message is Map) {
      return message.entries
          .map((e) => e.value is List ? (e.value as List).join('\n') : e.value.toString())
          .join('\n');
    } else if (message is List) {
      return message.join('\n');
    } else if (message is String) {
      return message;
    }
    return 'حدث خطأ غير متوقع';
  }
}
