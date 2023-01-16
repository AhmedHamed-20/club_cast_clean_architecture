import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class ServerErrorMessageModel extends Equatable {
  final String message;

  const ServerErrorMessageModel({
    required this.message,
  });

  factory ServerErrorMessageModel.fromDioException(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.connectTimeout:
        return const ServerErrorMessageModel(
          message: 'Connection Timeout',
        );
      case DioErrorType.sendTimeout:
        return const ServerErrorMessageModel(
          message: 'Send Timeout',
        );
      case DioErrorType.receiveTimeout:
        return const ServerErrorMessageModel(
          message: 'Receive Timeout',
        );
      case DioErrorType.response:
        return ServerErrorMessageModel.fromResponse(dioError.response!);
      case DioErrorType.cancel:
        return const ServerErrorMessageModel(
          message: 'Request Cancelled',
        );
      case DioErrorType.other:
        if (dioError.message.contains('SocketException') ||
            dioError.message.contains('HttpException')) {
          return const ServerErrorMessageModel(
            message: 'No Internet Connection',
          );
        }
        return const ServerErrorMessageModel(
          message: 'Unexpected Error',
        );
    }
  }

  factory ServerErrorMessageModel.fromResponse(Response response) {
    if (response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 403) {
      return ServerErrorMessageModel(message: response.data['message']);
    } else if (response.statusCode == 404) {
      return const ServerErrorMessageModel(message: 'Not Found');
    } else if (response.statusCode == 500 ||
        response.statusCode == 502 ||
        response.statusCode == 503 ||
        response.statusCode == 504) {
      return const ServerErrorMessageModel(message: 'Internal Server Error');
    } else {
      return const ServerErrorMessageModel(message: 'Unexpected Error');
    }
  }
  @override
  List<Object?> get props => [
        message,
      ];
}

class LocalErrorsMessageModel extends Equatable {
  final String errorMessage;

  const LocalErrorsMessageModel({required this.errorMessage});

  factory LocalErrorsMessageModel.fromException(Object? error) {
    return LocalErrorsMessageModel(errorMessage: error.toString());
  }
  @override
  List<Object?> get props => [errorMessage];
}
