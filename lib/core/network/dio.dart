import 'package:club_cast_clean_architecture/core/services/service_locator.dart';
import 'package:dio/dio.dart';

import 'network_service.dart';

class DioHelper extends NetworkService {
  final Dio dio;
  DioHelper(
    this.dio,
  );
  @override
  Future<Response<dynamic>> getData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    ProgressCallback? onReceiveProgress,
  }) async {
    return await servicelocator<Dio>().get(
      url,
      queryParameters: query,
      onReceiveProgress: onReceiveProgress,
      options: Options(
        headers: headers,
      ),
    );
  }

  @override
  Future<Response<dynamic>> postData({
    required String url,
    dynamic data,
    Map<String, dynamic>? headers,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    return await dio.post(
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      url,
      cancelToken: cancelToken,
      data: data,
      options: Options(headers: headers),
    );
  }

  @override
  Future<dynamic> deleteData(
      {String? url,
      Map<String, dynamic>? query,
      Map<String, dynamic>? headers}) async {
    return await dio.delete(
      url!,
      queryParameters: query,
      options: Options(headers: headers),
    );
  }

  @override
  Future<dynamic> patchData({
    String? url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    dynamic data,
  }) async {
    return await dio.patch(
      data: data,
      url!,
      queryParameters: query,
      options: Options(headers: headers),
    );
  }

  @override
  Future<Response<dynamic>> downloadData(
      {required String url,
      required String savedPath,
      CancelToken? cancelToken,
      void Function(int, int)? onReceive}) async {
    return await dio.download(
      url,
      savedPath,
      cancelToken: cancelToken,
      onReceiveProgress: onReceive,
    );
  }
}
