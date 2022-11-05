import 'package:club_cast_clean_architecture/core/error/error_message_model.dart';

class ServerException implements Exception {
  final ServerErrorMessageModel serverErrorMessageModel;

  const ServerException({required this.serverErrorMessageModel});
}

class CacheException implements Exception {
  final LocalErrorsMessageModel localErrorsMessageModel;

  CacheException(this.localErrorsMessageModel);
}

class AppDataBaseException implements Exception {
  final LocalErrorsMessageModel dataBaseErrorMessageModel;

  const AppDataBaseException(this.dataBaseErrorMessageModel);
}
