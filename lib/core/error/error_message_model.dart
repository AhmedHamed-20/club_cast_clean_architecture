import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

class ServerErrorMessageModel extends Equatable {
  final String message;
  final int? statusCode;
  const ServerErrorMessageModel({
    required this.message,
    this.statusCode,
  });

  factory ServerErrorMessageModel.fromException(Exception exception) {
    if (exception is DioError) {
      switch (exception.type) {
        case DioErrorType.connectTimeout:
          return ServerErrorMessageModel(
            message: AppStrings.connectionTimeout.tr(),
          );
        case DioErrorType.sendTimeout:
          return ServerErrorMessageModel(
            message: AppStrings.sendTimeout.tr(),
          );
        case DioErrorType.receiveTimeout:
          return ServerErrorMessageModel(
            message: AppStrings.receiveTimeout.tr(),
          );
        case DioErrorType.response:
          return ServerErrorMessageModel.fromResponse(exception.response!);
        case DioErrorType.cancel:
          return ServerErrorMessageModel(
            message: AppStrings.requestCancelled.tr(),
          );
        case DioErrorType.other:
          if (exception.message.contains('SocketException') ||
              exception.message.contains('HttpException')) {
            return ServerErrorMessageModel(
              message: AppStrings.noInternet.tr(),
            );
          }
          return ServerErrorMessageModel(
            message: AppStrings.unExpectedError.tr(),
          );
      }
    } else {
      return ServerErrorMessageModel(
        message: AppStrings.unExpectedError.tr(),
      );
    }
  }

  factory ServerErrorMessageModel.fromResponse(Response response) {
    if (response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 403) {
      return ServerErrorMessageModel(
        message: response.data['message'],
        statusCode: response.statusCode,
      );
    } else if (response.statusCode == 404) {
      return ServerErrorMessageModel(message: AppStrings.notFound.tr());
    } else if (response.statusCode == 500 ||
        response.statusCode == 502 ||
        response.statusCode == 503 ||
        response.statusCode == 504) {
      return ServerErrorMessageModel(
          message: AppStrings.internalServerError.tr());
    } else {
      return ServerErrorMessageModel(message: AppStrings.unExpectedError.tr());
    }
  }
  @override
  List<Object?> get props => [
        message,
        statusCode,
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
