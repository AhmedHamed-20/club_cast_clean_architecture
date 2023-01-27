import 'package:club_cast_clean_architecture/core/services/service_locator.dart';
import 'package:dio/dio.dart';

class DioHelper {
  Response? response;
  Dio dio;
  DioHelper(
    this.dio,
  );

  Future<Response<dynamic>?> getData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    ProgressCallback? onReceiveProgress,
  }) async {
    return response = await servicelocator<Dio>().get(
      url,
      queryParameters: query,
      onReceiveProgress: onReceiveProgress,
      options: Options(
        headers: headers,
      ),
    );
  }

  Future<Response<dynamic>?> postData({
    required String url,
    dynamic data,
    Map<String, dynamic>? headers,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    return response = await dio.post(
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      url,
      cancelToken: cancelToken,
      data: data,
      options: Options(headers: headers),
    );
  }

  Future<dynamic> deleteData(
      {String? url,
      Map<String, dynamic>? query,
      Map<String, dynamic>? headers}) async {
    return response = await dio.delete(
      url!,
      queryParameters: query,
      options: Options(headers: headers),
    );
  }

  Future<dynamic> patchData({
    String? url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    dynamic data,
  }) async {
    return response = await dio.patch(
      data: data,
      url!,
      queryParameters: query,
      options: Options(headers: headers),
    );
  }

  Future<Response<dynamic>> downloadData(
      {required String url,
      required String savedPath,
      CancelToken? cancelToken,
      void Function(int, int)? onReceive}) async {
    return response = await dio.download(
      url,
      savedPath,
      cancelToken: cancelToken,
      onReceiveProgress: onReceive,
    );
  }
}
