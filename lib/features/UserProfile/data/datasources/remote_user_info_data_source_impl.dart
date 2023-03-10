import 'package:club_cast_clean_architecture/core/error/error_message_model.dart';
import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/network/dio.dart';
import 'package:club_cast_clean_architecture/core/network/endpoints.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/data/models/my_events_model.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/data/models/other_users_basic_info_model.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/data/models/podcast_upload_model.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/data/models/signature_model.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/data/models/update_user_data_model.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/events/create_event.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/events/get_my_events.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/events/remove_event.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/events/update_event.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/podcasts/get_my_podcasts.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/podcasts/remove_podcast.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/upload_podcast_usecase/create_podcast.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/upload_podcast_usecase/upload_podcast.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/get_followers.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/update_password.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/update_user_info.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../core/services/service_locator.dart';
import '../../domain/usecases/upload_podcast_usecase/generate_signature.dart';
import '../../domain/usecases/user_information/update_user_image.dart';
import '../models/my_podcast_model.dart';

abstract class BaseUserInfoRemoteDataSource {
  Future<MyPodcastModel> getMyPodcasts(MyPodcastGetParams params);
  Future<SignatureModel> generateSignature(SignatureGenerateParams params);
  Future<PodcastUploadModel> uploadPodcast(PodcastUploadParams params);
  Future<void> createPodcast(PodcastCreateParams params);
  Future<UpdatedUserDataInfoModel> updateUserData(UserDataUpdateParams params);
  Future<String> updatePassword(PasswordUpdateParams params);
  Future<void> createEvent(EventCreateParams params);
  Future<MyEventsModel> getMyEvents(MyEventsParams params);

  Future<OtherUsersDataModel> getFollowers(FollowersFollowingParams params);
  Future<OtherUsersDataModel> getFollowing(FollowersFollowingParams params);

  Future<void> removePodcast(PodcastRemoveParams params);

  Future<void> removeEvent(EventRemoveUsecaseParams params);

  Future<void> updateEvent(EventUpdateUsecaseParams params);
  Future<void> updateUserPhoto(UpdateUserImageUsecaseParams params);
}

class RemoteUserInfoDataSourceImpl extends BaseUserInfoRemoteDataSource {
  @override
  Future<MyPodcastModel> getMyPodcasts(MyPodcastGetParams params) async {
    try {
      final response = await servicelocator<DioHelper>()
          .getData(url: EndPoints.getMyPodCasts, headers: {
        'Authorization': 'Bearer ${params.accessToken}',
      }, query: {
        'page': params.page,
      });
      return MyPodcastModel.fromJson(response?.data);
    } on DioError catch (e) {
      throw ServerException(
        serverErrorMessageModel: ServerErrorMessageModel.fromDioException(e),
      );
    }
  }

  @override
  Future<SignatureModel> generateSignature(
      SignatureGenerateParams params) async {
    try {
      final respone = await servicelocator<DioHelper>().getData(
          url: EndPoints.generateSignature,
          headers: {'Authorization': 'Bearer ${params.accessToken}'});
      return SignatureModel.fromJson(respone?.data);
    } on DioError catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromDioException(e));
    }
  }

  @override
  Future<PodcastUploadModel> uploadPodcast(PodcastUploadParams params) async {
    try {
      final respone = await servicelocator<DioHelper>().postData(
        url: EndPoints.uploadPodcast(
            apiKey: params.apiKey,
            cloudName: params.cloudName,
            signature: params.signature,
            timestamp: params.timestamp),
        headers: {
          'Authorization': 'Bearer ${params.accessToken}',
        },
        cancelToken: params.cancelToken,
        onSendProgress: (count, total) {
          final progress = (count / total);
          params.uploadController.add(progress);
        },
        data: FormData.fromMap({
          'file': await MultipartFile.fromFile(
            params.filePath,
            filename: params.podcastName,
            contentType: MediaType('audio', 'mp3'),
          ),
          'folder': 'podcasts',
          'resource_type': 'auto',
        }),
      );
      return PodcastUploadModel.fromJson(respone?.data);
    } on DioError catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromDioException(e));
    }
  }

  @override
  Future<void> createPodcast(PodcastCreateParams params) async {
    try {
      await servicelocator<DioHelper>()
          .postData(url: EndPoints.createPodCast, headers: {
        'Authorization': 'Bearer ${params.accessToken}',
      }, data: {
        'name': params.podcastName,
        'category': params.category,
        'audio': {'public_id': params.publicId}
      });
    } on DioError catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromDioException(e));
    }
  }

  @override
  Future<UpdatedUserDataInfoModel> updateUserData(
      UserDataUpdateParams params) async {
    try {
      final response = await servicelocator<DioHelper>()
          .patchData(url: EndPoints.updateProfile, headers: {
        'Authorization': 'Bearer ${params.accessToken}',
      }, data: {
        'name': params.name,
        'email': params.email,
        'bio': params.bio,
      });
      return UpdatedUserDataInfoModel.fromJson(response?.data['user']);
    } on DioError catch (e) {
      throw ServerException(
        serverErrorMessageModel: ServerErrorMessageModel.fromDioException(
          e,
        ),
      );
    }
  }

  @override
  Future<String> updatePassword(PasswordUpdateParams params) async {
    try {
      final response = await servicelocator<DioHelper>()
          .patchData(url: EndPoints.updatePassword, headers: {
        'Authorization': 'Bearer ${params.accessToken}',
      }, data: {
        "passwordCurrent": params.currentPassword,
        "password": params.newPassword,
        "passwordConfirm": params.confirmPassword,
      });
      return response?.data['token'];
    } on DioError catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromDioException(e));
    }
  }

  @override
  Future<void> createEvent(EventCreateParams params) async {
    try {
      await servicelocator<DioHelper>().postData(
        url: EndPoints.createEvent,
        headers: {
          'Authorization': 'Bearer ${params.accessToken}',
        },
        data: {
          "name": params.eventName,
          "description": params.eventDescription,
          "date": params.eventDate,
        },
      );
    } on DioError catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromDioException(e));
    }
  }

  @override
  Future<MyEventsModel> getMyEvents(MyEventsParams params) async {
    try {
      final response = await servicelocator<DioHelper>()
          .getData(url: EndPoints.getMyEvent, headers: {
        'Authorization': 'Bearer ${params.accessToken}',
      }, query: {
        'page': params.page
      });
      return MyEventsModel.fromJson(response?.data);
    } on DioError catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromDioException(e));
    }
  }

  @override
  Future<OtherUsersDataModel> getFollowers(
      FollowersFollowingParams params) async {
    try {
      final response = await servicelocator<DioHelper>()
          .getData(url: EndPoints.myFollowers, headers: {
        'Authorization': 'Bearer ${params.accessToken}',
      }, query: {
        'page': params.page
      });
      return OtherUsersDataModel.fromJson(response?.data);
    } on DioError catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromDioException(e));
    }
  }

  @override
  Future<OtherUsersDataModel> getFollowing(
      FollowersFollowingParams params) async {
    try {
      final response = await servicelocator<DioHelper>()
          .getData(url: EndPoints.myFollowing, headers: {
        'Authorization': 'Bearer ${params.accessToken}',
      }, query: {
        'page': params.page
      });
      return OtherUsersDataModel.fromJson(response?.data);
    } on DioError catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromDioException(e));
    }
  }

  @override
  Future<void> removePodcast(PodcastRemoveParams params) async {
    try {
      await servicelocator<DioHelper>().deleteData(
        url: EndPoints.removePodCastById + params.podcastId,
        headers: {
          'Authorization': 'Bearer ${params.accessToken}',
        },
      );
    } on DioError catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromDioException(e));
    }
  }

  @override
  Future<void> removeEvent(EventRemoveUsecaseParams params) async {
    try {
      await servicelocator<DioHelper>().deleteData(
        url: EndPoints.deleteEvent + params.eventID,
        headers: {
          'Authorization': 'Bearer ${params.accessToken}',
        },
      );
    } on DioError catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromDioException(e));
    }
  }

  @override
  Future<void> updateEvent(EventUpdateUsecaseParams params) async {
    try {
      await servicelocator<DioHelper>()
          .patchData(url: EndPoints.updateEventData + params.eventID, headers: {
        'Authorization': 'Bearer ${params.accessToken}',
      }, data: {
        "title": params.eventName,
        "description": params.eventDescription,
        "date": params.eventDate,
      });
    } on DioError catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromDioException(e));
    }
  }

  @override
  Future<void> updateUserPhoto(UpdateUserImageUsecaseParams params) async {
    try {
      await servicelocator<DioHelper>().patchData(
        url: EndPoints.updateAvatar,
        headers: {
          'Authorization': 'Bearer ${params.accessToken}',
        },
        data: FormData.fromMap({
          'photo': await MultipartFile.fromFile(
            params.imagePath,
            contentType: MediaType('image', 'png'),
          ),
        }),
      );
    } on DioError catch (e) {
      throw ServerException(
          serverErrorMessageModel: ServerErrorMessageModel.fromDioException(e));
    }
  }
}
