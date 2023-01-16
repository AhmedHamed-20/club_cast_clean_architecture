import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/my_event_entitie.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/my_podcast_entitie.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/other_users_basic_info_entitie.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/updated_user_data_info.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/events/create_event.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/events/get_my_events.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/events/update_event.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/podcasts/add_like.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/podcasts/remove_podcast.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/upload_podcast_usecase/create_podcast.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/upload_podcast_usecase/generate_signature.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/upload_podcast_usecase/upload_podcast.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/get_followers.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/get_following.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/get_more_followers.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/get_more_following.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/update_password.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/update_user_image.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/update_user_info.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../../../core/utl/utls.dart';
import '../../domain/usecases/events/remove_event.dart';
import '../../domain/usecases/podcasts/get_my_podcasts.dart';
import '../../domain/usecases/podcasts/remove_like.dart';

part 'userprofile_event.dart';
part 'userprofile_state.dart';

class UserProfileBloc extends Bloc<UserprofileEvent, UserProfileState> {
  UserProfileBloc(
      this.myPodcastsGetUseCase,
      this.signatureGenerateUsecase,
      this.myFollowersGetUseCase,
      this.myFollowingGetUseCase,
      this.userDataUpdateUseCase,
      this.podcastCreateUseCase,
      this.passwordUpdateUseCase,
      this.eventCreateUseCase,
      this.myEventsGetUsecase,
      this.likeAddMyPodcastsUsecast,
      this.likeRemoveByPodcastIdUsecase,
      this.moreFollowersGetUsecase,
      this.moreFollowingGetUsecase,
      this.podcastRemoveUsecase,
      this.eventRemoveUsecase,
      this.eventUpdateUsecase,
      this.updateUserImageUsecase,
      this.podcastUploadUsecase)
      : super(const UserProfileState()) {
    on<MyPodcastsGetEvent>(_getMyPodcasts);
    on<SignatureGenerateEventEvent>(_generateSignature);
    on<UserDataUpdateEvent>(_updateUserData);
    on<UploadPodcastEvent>(_uploadPodcastToCloud);
    on<CreatePodcastEvent>(_createPodcastInDataBase);
    on<PasswordUpdateEvent>(_updatePassword);
    on<EventCreateEvent>(_createEvent);
    on<MyEventsGetEvent>(_getMyEvents);
    on<BackGroundColorGenerateEvent>(_generateBackGroundImageColor);
    on<LikeAddMyPodcastEvent>(_addLike);
    on<LikeRemoveMyPodcastEvent>(_removeLike);
    on<MyFollowersGetEvent>(_getMyFollwers);
    on<MyFollowingGetEvent>(_getMyFollowing);
    on<MyFollowersGetMoreEvent>(_getMoreFollowers);
    on<MyFollowingGetMoreEvent>(_getMoreFollowing);
    on<PodcastRemoveEvent>(_removePodcast);
    on<EventRemoveEvent>(_removeEvent);
    on<EventUpdateDataEvent>(_updateEvent);
    on<PickPodcastFileEvent>(_pickPodcastFile);
    on<ClearPodcastFileEvent>(_clearPodcastFile);
    on<PickImageEvent>(_pickImage);
    on<UserImageUpdateEvent>(_updateUserImage);
  }
  final MyPodcastsGetUseCase myPodcastsGetUseCase;
  final SignatureGenerateUsecase signatureGenerateUsecase;
  final UserDataUpdateUseCase userDataUpdateUseCase;
  final PodcastUploadUsecase podcastUploadUsecase;
  final PodcastCreateUseCase podcastCreateUseCase;
  final PasswordUpdateUseCase passwordUpdateUseCase;
  final EventCreateUseCase eventCreateUseCase;
  final UpdateUserImageUsecase updateUserImageUsecase;
  final MyEventsGetUsecase myEventsGetUsecase;
  final LikeAddMyPodcastsUsecast likeAddMyPodcastsUsecast;
  final LikeRemoveMyPodcastsUsecast likeRemoveByPodcastIdUsecase;
  final MyFollowersGetUseCase myFollowersGetUseCase;
  final MyFollowingGetUseCase myFollowingGetUseCase;
  final MoreFollowersGetUsecase moreFollowersGetUsecase;
  final MoreFollowingGetUsecase moreFollowingGetUsecase;
  final PodcastRemoveUsecase podcastRemoveUsecase;
  final EventRemoveUsecase eventRemoveUsecase;
  final EventUpdateUsecase eventUpdateUsecase;
  FutureOr<void> _getMyPodcasts(
      MyPodcastsGetEvent event, Emitter<UserProfileState> emit) async {
    final result =
        await myPodcastsGetUseCase(MyPodcastGetParams(event.accessToken));
    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            myPodCastequestStatus: MyPodCastRequestStatus.error)),
        (r) => emit(state.copyWith(
            errorMessage: '',
            myPodCastequestStatus: MyPodCastRequestStatus.success,
            myPodcastEntite: r)));
  }

  FutureOr<void> _generateSignature(
      SignatureGenerateEventEvent event, Emitter<UserProfileState> emit) async {
    emit(state.copyWith(
        errorMessage: '',
        uploadPodcastRequestStatus: UploadPodcastRequestStatus.loading));
    final result = await signatureGenerateUsecase(
        SignatureGenerateParams(event.accessToken));
    result.fold(
        (l) => emit(
              state.copyWith(
                errorMessage: l.message,
                uploadPodcastRequestStatus: UploadPodcastRequestStatus.error,
              ),
            ), (r) {
      emit(
        state.copyWith(
          errorMessage: '',
          uploadPodcastRequestStatus:
              UploadPodcastRequestStatus.signatureGetSuccess,
        ),
      );
      add(
        UploadPodcastEvent(
          podcastCategory: event.podcastCategory,
          cancelToken: event.cancelToken,
          podcastName: event.podcastName,
          uploadProgress: event.uploadProgress,
          filePath: event.filePath,
          accessToken: event.accessToken,
          timestamp: r.timestamp,
          cloudName: r.cloudName,
          apiKey: r.apiKey,
          signature: r.signature,
        ),
      );
    });
  }

  FutureOr<void> _updateUserData(
      UserDataUpdateEvent event, Emitter<UserProfileState> emit) async {
    emit(state.copyWith(
        updateUserDataRequestStatus: UpdateUserDataRequestStatus.loading));
    final result = await userDataUpdateUseCase(
      UserDataUpdateParams(
        email: event.email,
        name: event.name,
        bio: event.bio,
        accessToken: event.accessToken,
      ),
    );
    result.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          updateUserDataRequestStatus: UpdateUserDataRequestStatus.error,
        ),
      ),
      (r) => emit(
        state.copyWith(
          errorMessage: '',
          updatedUserDataInfoEntitie: r,
          updateUserDataRequestStatus: UpdateUserDataRequestStatus.success,
        ),
      ),
    );
  }

  FutureOr<void> _uploadPodcastToCloud(
      UploadPodcastEvent event, Emitter<UserProfileState> emit) async {
    final result = await podcastUploadUsecase(
      PodcastUploadParams(
        cancelToken: event.cancelToken,
        podcastName: event.podcastName,
        uploadController: event.uploadProgress,
        accessToken: event.accessToken,
        timestamp: event.timestamp,
        filePath: event.filePath,
        cloudName: event.cloudName,
        apiKey: event.apiKey,
        signature: event.signature,
      ),
    );
    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            uploadPodcastRequestStatus: UploadPodcastRequestStatus.error)),
        (r) {
      emit(
        state.copyWith(
          errorMessage: '',
          uploadPodcastRequestStatus:
              UploadPodcastRequestStatus.podcastUploadedSuccess,
        ),
      );
      add(
        CreatePodcastEvent(
          accessToken: event.accessToken,
          podcastName: r.name,
          category: event.podcastCategory,
          publicId: r.publicId,
        ),
      );
    });
  }

  FutureOr<void> _createPodcastInDataBase(
      CreatePodcastEvent event, Emitter<UserProfileState> emit) async {
    final result = await podcastCreateUseCase(
      PodcastCreateParams(
        accessToken: event.accessToken,
        podcastName: event.podcastName,
        category: event.category,
        publicId: event.publicId,
      ),
    );
    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            uploadPodcastRequestStatus: UploadPodcastRequestStatus.error)),
        (r) {
      emit(
        state.copyWith(
          errorMessage: '',
          uploadPodcastRequestStatus:
              UploadPodcastRequestStatus.podcastCreatedSucess,
        ),
      );
      add(MyPodcastsGetEvent(event.accessToken));
    });
  }

  FutureOr<void> _updatePassword(
      PasswordUpdateEvent event, Emitter<UserProfileState> emit) async {
    emit(state.copyWith(
        updatePasswordRequestStatus: UpdateUserDataRequestStatus.loading));
    final result = await passwordUpdateUseCase(
      PasswordUpdateParams(
        accessToken: event.accessToken,
        currentPassword: event.currentPassword,
        newPassword: event.newPassword,
        confirmPassword: event.confirmPassword,
      ),
    );
    result.fold(
      (l) => emit(state.copyWith(
          errorMessage: l.message,
          updatePasswordRequestStatus: UpdateUserDataRequestStatus.error)),
      (r) => emit(
        state.copyWith(
            errorMessage: '',
            updatePasswordRequestStatus: UpdateUserDataRequestStatus.success),
      ),
    );
  }

  FutureOr<void> _createEvent(
      EventCreateEvent event, Emitter<UserProfileState> emit) async {
    emit(state.copyWith(
        eventCreateRequestStatus: EventCreateRequestStatus.loading));
    final result = await eventCreateUseCase(EventCreateParams(
      accessToken: event.accessToken,
      eventName: event.eventName,
      eventDescription: event.eventDescription,
      eventDate: event.eventDate,
    ));

    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            eventCreateRequestStatus: EventCreateRequestStatus.error)), (r) {
      emit(state.copyWith(
          errorMessage: '',
          eventCreateRequestStatus: EventCreateRequestStatus.success));
      add(MyEventsGetEvent(event.accessToken));
    });
  }

  FutureOr<void> _getMyEvents(
      MyEventsGetEvent event, Emitter<UserProfileState> emit) async {
    final result = await myEventsGetUsecase(MyEventsParams(event.accessToken));
    result.fold(
      (l) => emit(state.copyWith(
          errorMessage: l.message,
          myEventRequestStatus: UserDataGetRequestStatus.error)),
      (r) => emit(
        state.copyWith(
            errorMessage: '',
            myEvents: r,
            myEventRequestStatus: UserDataGetRequestStatus.success),
      ),
    );
  }

  FutureOr<void> _generateBackGroundImageColor(
      BackGroundColorGenerateEvent event,
      Emitter<UserProfileState> emit) async {
    emit(state.copyWith(
        backGroundColorGenerateRequestStatus:
            BackGroundColorGenerateRequestStatus.loading,
        backGroundColors: const []));
    final paletteGenerator = await PaletteGenerator.fromImageProvider(
      NetworkImage(event.imageUrl),
      maximumColorCount: 20,
    );
    if (paletteGenerator.colors.isNotEmpty) {
      paletteGenerator.paletteColors;
      emit(state.copyWith(
          backGroundColorGenerateRequestStatus:
              BackGroundColorGenerateRequestStatus.generated,
          backGroundColors: paletteGenerator.paletteColors));
    } else {
      emit(state.copyWith(
          backGroundColorGenerateRequestStatus:
              BackGroundColorGenerateRequestStatus.error,
          backGroundColors: const []));
    }
  }

  FutureOr<void> _addLike(
      LikeAddMyPodcastEvent event, Emitter<UserProfileState> emit) async {
    final result = await likeAddMyPodcastsUsecast(LikeAddMyPodcastsParams(
        accessToken: event.accessToken, podcastId: event.podcastId));
    result.fold((l) => emit(state.copyWith(errorMessage: '')), (r) {
      add(MyPodcastsGetEvent(event.accessToken));
    });
  }

  FutureOr<void> _removeLike(
      LikeRemoveMyPodcastEvent event, Emitter<UserProfileState> emit) async {
    final result = await likeRemoveByPodcastIdUsecase(
        LikeRemoveMyPodcastsParams(
            accessToken: event.accessToken, podcastId: event.podcastId));
    result.fold((l) => emit(state.copyWith(errorMessage: '')), (r) {
      add(MyPodcastsGetEvent(event.accessToken));
    });
  }

  FutureOr<void> _getMyFollwers(
      MyFollowersGetEvent event, Emitter<UserProfileState> emit) async {
    emit(state.copyWith(
        getMyFollowersRequestStatus: UserDataGetRequestStatus.loading));
    final result = await myFollowersGetUseCase(
        FollowersFollowingParams(event.accessToken));
    result.fold(
        (l) => emit(state.copyWith(
            getMyFollowersRequestStatus: UserDataGetRequestStatus.error,
            errorMessage: l.message)),
        (r) => emit(state.copyWith(
            followersData: r,
            getMyFollowersRequestStatus: UserDataGetRequestStatus.success,
            errorMessage: '')));
  }

  FutureOr<void> _getMyFollowing(
      MyFollowingGetEvent event, Emitter<UserProfileState> emit) async {
    emit(state.copyWith(
        getMyFollowingRequestStatus: UserDataGetRequestStatus.loading));
    final result = await myFollowingGetUseCase(
        FollowersFollowingParams(event.accessToken));
    result.fold(
        (l) => emit(state.copyWith(
            getMyFollowingRequestStatus: UserDataGetRequestStatus.error,
            errorMessage: l.message)),
        (r) => emit(state.copyWith(
            followingData: r,
            getMyFollowingRequestStatus: UserDataGetRequestStatus.success,
            errorMessage: '')));
  }

  FutureOr<void> _getMoreFollowers(
      MyFollowersGetMoreEvent event, Emitter<UserProfileState> emit) async {
    final result = await moreFollowersGetUsecase(
        MoreFollowersFollowingGetParams(
            accessToken: event.accessToken, page: event.page));

    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message, isEndOfFollowersData: true)), (r) {
      if (r.result == 0) {
        emit(state.copyWith(
          isEndOfFollowersData: true,
        ));
      } else if (r.result == 10) {
        OtherUsersDataEntitie followersEntitie;
        followersEntitie = state.followersData!;

        followersEntitie.followerFollowigDataEntite
            .addAll(r.followerFollowigDataEntite);

        emit(state.copyWith(
          errorMessage: '',
          followersData: followersEntitie,
          isEndOfFollowersData: false,
        ));
      } else {
        OtherUsersDataEntitie followersEntitie = state.followersData!;
        followersEntitie.followerFollowigDataEntite
            .addAll(r.followerFollowigDataEntite);
        emit(state.copyWith(
          errorMessage: '',
          followersData: followersEntitie,
          isEndOfFollowersData: true,
        ));
      }
    });
  }

  FutureOr<void> _getMoreFollowing(
      MyFollowingGetMoreEvent event, Emitter<UserProfileState> emit) async {
    final result = await moreFollowingGetUsecase(
        MoreFollowersFollowingGetParams(
            accessToken: event.accessToken, page: event.page));

    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message, isEndOfFollowingData: true)), (r) {
      if (r.result == 0) {
        emit(state.copyWith(
          isEndOfFollowingData: true,
        ));
      } else if (r.result == 10) {
        OtherUsersDataEntitie followingData;
        followingData = state.followingData!;

        followingData.followerFollowigDataEntite
            .addAll(r.followerFollowigDataEntite);

        emit(state.copyWith(
          errorMessage: '',
          followingData: followingData,
          isEndOfFollowingData: false,
        ));
      } else {
        OtherUsersDataEntitie followingData = state.followingData!;
        followingData.followerFollowigDataEntite
            .addAll(r.followerFollowigDataEntite);
        emit(state.copyWith(
          errorMessage: '',
          followingData: followingData,
          isEndOfFollowingData: true,
        ));
      }
    });
  }

  FutureOr<void> _removePodcast(
      PodcastRemoveEvent event, Emitter<UserProfileState> emit) async {
    emit(state.copyWith(
        myPodCastRemoveRequestStatus: MyDataRemoveRequestStatus.loading));
    final result = await podcastRemoveUsecase(PodcastRemoveParams(
        accessToken: event.accessToken, podcastId: event.podcastId));
    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            myPodCastRemoveRequestStatus: MyDataRemoveRequestStatus.error)),
        (r) {
      emit(state.copyWith(
          errorMessage: '',
          myPodCastRemoveRequestStatus: MyDataRemoveRequestStatus.removed));
      add(MyPodcastsGetEvent(event.accessToken));
    });
  }

  FutureOr<void> _removeEvent(
      EventRemoveEvent event, Emitter<UserProfileState> emit) async {
    emit(state.copyWith(
        myEventRemoveRequestStatus: MyDataRemoveRequestStatus.loading));
    final result = await eventRemoveUsecase(EventRemoveUsecaseParams(
        accessToken: event.accessToken, eventID: event.eventId));

    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            myEventRemoveRequestStatus: MyDataRemoveRequestStatus.error)), (r) {
      emit(state.copyWith(
          errorMessage: '',
          myEventRemoveRequestStatus: MyDataRemoveRequestStatus.removed));
      add(MyEventsGetEvent(event.accessToken));
    });
  }

  FutureOr<void> _updateEvent(
      EventUpdateDataEvent event, Emitter<UserProfileState> emit) async {
    emit(state.copyWith(
        myEventUpdateRequestStatus: MyDataUpdateRequestStatus.loading));
    final result = await eventUpdateUsecase(EventUpdateUsecaseParams(
        accessToken: event.accessToken,
        eventDescription: event.eventDescription,
        eventName: event.eventName,
        eventID: event.eventId,
        eventDate: event.eventDate));

    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            myEventUpdateRequestStatus: MyDataUpdateRequestStatus.error)), (r) {
      emit(state.copyWith(
          errorMessage: '',
          myEventUpdateRequestStatus: MyDataUpdateRequestStatus.updated));
      add(MyEventsGetEvent(event.accessToken));
    });
  }

  FutureOr<void> _pickPodcastFile(
      PickPodcastFileEvent event, Emitter<UserProfileState> emit) async {
    try {
      final pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.audio,
      );
      if (pickedFile!.files.first.size <= 100000000) {
        emit(
            state.copyWith(pickedPodcastFilePath: pickedFile.files.first.path));
      } else {
        flutterToast(
            msg: 'File size must be less than 100 MB',
            backgroundColor: AppColors.toastError,
            textColor: AppColors.white);
      }
    } on Exception catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _clearPodcastFile(
      ClearPodcastFileEvent event, Emitter<UserProfileState> emit) {
    emit(state.copyWith(
        pickedPodcastFilePath: '',
        uploadPodcastRequestStatus: UploadPodcastRequestStatus.idle));
  }

  FutureOr<void> _pickImage(
      PickImageEvent event, Emitter<UserProfileState> emit) async {
    try {
      final pickkImage = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      emit(
        state.copyWith(
          pickedUserProfileImageFilePath: pickkImage!.files.first.path,
        ),
      );
    } on Exception catch (e) {
      emit(state.copyWith(
          errorMessage: e.toString(), pickedUserProfileImageFilePath: ''));
    }
  }

  FutureOr<void> _updateUserImage(
      UserImageUpdateEvent event, Emitter<UserProfileState> emit) async {
    emit(state.copyWith(
        updateUserPhotoRequestStatus: UpdateUserDataRequestStatus.loading));
    final result = await updateUserImageUsecase(UpdateUserImageUsecaseParams(
        accessToken: event.accessToken, imagePath: event.photoUrl));

    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            updateUserPhotoRequestStatus: UpdateUserDataRequestStatus.error)),
        (r) => emit(state.copyWith(
            errorMessage: '',
            pickedUserProfileImageFilePath: '',
            updateUserPhotoRequestStatus:
                UpdateUserDataRequestStatus.success)));
  }
}
