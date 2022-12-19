import 'package:club_cast_clean_architecture/core/error/error_message_model.dart';
import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/network/dio.dart';
import 'package:club_cast_clean_architecture/core/network/endpoints.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/data/models/my_podcast_model.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/data/models/podcast_upload_model.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/data/models/signature_model.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/data/models/update_user_data_model.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/podcasts/get_my_podcasts.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/upload_podcast_usecase/create_podcast.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/upload_podcast_usecase/upload_podcast.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/update_password.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/update_user_info.dart';
import 'package:dio/dio.dart';

import '../../domain/usecases/upload_podcast_usecase/generate_signature.dart';

abstract class BaseUserInfoRemoteDataSource {
  Future<List<MyPodcastsModel>> getMyPodcasts(MyPodcastGetParams params);
  Future<SignatureModel> generateSignature(SignatureGenerateParams params);
  Future<PodcastUploadModel> uploadPodcast(PodcastUploadParams params);
  Future<void> createPodcast(PodcastCreateParams params);
  Future<UpdatedUserDataInfoModel> updateUserData(UserDataUpdateParams params);
  Future<String> updatePassword(PasswordUpdateParams params);
}

class RemoteUserInfoDataSourceImpl extends BaseUserInfoRemoteDataSource {
  @override
  Future<List<MyPodcastsModel>> getMyPodcasts(MyPodcastGetParams params) async {
    try {
      final response = await DioHelper.getData(
        url: EndPoints.getMyPodCasts,
        headers: {'Authorization': 'Bearer ${params.accessToken}'},
      );
      return (response?.data['data'] as List)
          .map((e) => MyPodcastsModel.fromJson(e))
          .toList();
    } on DioError catch (e) {
      throw ServerException(
        serverErrorMessageModel:
            ServerErrorMessageModel.fromJson(e.response?.data),
      );
    }
  }

  @override
  Future<SignatureModel> generateSignature(
      SignatureGenerateParams params) async {
    try {
      final respone = await DioHelper.getData(
          url: EndPoints.generateSignature,
          headers: {'Authorization': 'Bearer ${params.accessToken}'});
      return SignatureModel.fromJson(respone?.data);
    } on DioError catch (e) {
      throw ServerException(
          serverErrorMessageModel:
              ServerErrorMessageModel.fromJson(e.response?.data));
    }
  }

  @override
  Future<PodcastUploadModel> uploadPodcast(PodcastUploadParams params) async {
    try {
      final respone = await DioHelper.postData(
          url: EndPoints.uploadPodcast(
              apiKey: params.apiKey,
              cloudName: params.cloudName,
              signature: params.signature,
              timestamp: params.timestamp),
          headers: {
            'Authorization': 'Bearer ${params.accessToken}',
          },
          data: {
            'folder': 'podcasts',
            'resource_type': 'auto'
          });
      return PodcastUploadModel.fromJson(respone?.data);
    } on DioError catch (e) {
      throw ServerException(
          serverErrorMessageModel:
              ServerErrorMessageModel.fromJson(e.response?.data));
    }
  }

  @override
  Future<void> createPodcast(PodcastCreateParams params) async {
    try {
      await DioHelper.postData(url: EndPoints.createPodCast, headers: {
        'Authorization': 'Bearer ${params.accessToken}',
      }, data: {
        'name': params.podcastName,
        'category': params.category,
        'audio': {'public_id': params.publicId}
      });
    } on DioError catch (e) {
      throw ServerException(
          serverErrorMessageModel:
              ServerErrorMessageModel.fromJson(e.response?.data));
    }
  }

  @override
  Future<UpdatedUserDataInfoModel> updateUserData(
      UserDataUpdateParams params) async {
    try {
      final response =
          await DioHelper.patchData(url: EndPoints.updateProfile, headers: {
        'Authorization': 'Bearer ${params.accessToken}',
      }, data: {
        'name': params.name,
        'email': params.email,
        'bio': params.bio,
      });

      return UpdatedUserDataInfoModel.fromJson(response?.data['user']);
    } on DioError catch (e) {
      throw ServerException(
        serverErrorMessageModel: ServerErrorMessageModel.fromJson(
          e.response?.data,
        ),
      );
    }
  }

  @override
  Future<String> updatePassword(PasswordUpdateParams params) async {
    try {
      final response =
          await DioHelper.patchData(url: EndPoints.updatePassword, headers: {
        'Authorization': 'Bearer ${params.accessToken}',
      }, data: {
        "passwordCurrent": params.currentPassword,
        "password": params.newPassword,
        "passwordConfirm": params.confirmPassword,
      });
      return response?.data['token'];
    } on DioError catch (e) {
      throw ServerException(
          serverErrorMessageModel:
              ServerErrorMessageModel.fromJson(e.response?.data));
    }
  }
}
