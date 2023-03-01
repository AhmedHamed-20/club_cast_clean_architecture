import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/other_users_basic_info_entitie.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/updated_user_data_info.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/get_followers.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/get_following.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/update_password.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/update_user_image.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/update_user_info.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../../../core/utl/utls.dart';

part 'userprofile_event.dart';
part 'userprofile_state.dart';

class UserProfileBloc extends Bloc<UserprofileEvent, UserProfileState> {
  UserProfileBloc(
    this.myFollowersGetUseCase,
    this.myFollowingGetUseCase,
    this.userDataUpdateUseCase,
    this.passwordUpdateUseCase,
    this.updateUserImageUsecase,
  ) : super(const UserProfileState()) {
    on<UserDataUpdateEvent>(_updateUserData);
    on<PasswordUpdateEvent>(_updatePassword);
    on<BackGroundColorGenerateEvent>(_generateBackGroundImageColor);
    on<PasswordHideEvent>(_passwordHide);
    on<MyFollowersGetEvent>(_getMyFollwers);
    on<MyFollowingGetEvent>(_getMyFollowing);
    on<MyFollowersGetMoreEvent>(_getMoreFollowers);
    on<MyFollowingGetMoreEvent>(_getMoreFollowing);
    on<PickImageEvent>(_pickImage);
    on<UserImageUpdateEvent>(_updateUserImage);
  }
  final UserDataUpdateUseCase userDataUpdateUseCase;
  final PasswordUpdateUseCase passwordUpdateUseCase;
  final UpdateUserImageUsecase updateUserImageUsecase;
  final MyFollowersGetUseCase myFollowersGetUseCase;
  final MyFollowingGetUseCase myFollowingGetUseCase;

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
          statusCode: l.statusCode,
          errorMessage: l.message,
          updateUserDataRequestStatus: UpdateUserDataRequestStatus.error,
        ),
      ),
      (r) => emit(
        state.copyWith(
          errorMessage: '',
          statusCode: 0,
          updatedUserDataInfoEntitie: r,
          updateUserDataRequestStatus: UpdateUserDataRequestStatus.success,
        ),
      ),
    );
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
          statusCode: l.statusCode,
          errorMessage: l.message,
          updatePasswordRequestStatus: UpdateUserDataRequestStatus.error)),
      (r) => emit(
        state.copyWith(
            errorMessage: '',
            newToken: r,
            statusCode: 0,
            updatePasswordRequestStatus: UpdateUserDataRequestStatus.success),
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
    var paletteGenerator;
    try {
      paletteGenerator = await PaletteGenerator.fromImageProvider(
        CachedNetworkImageProvider(
          event.imageUrl,
          errorListener: () {},
        ),
        maximumColorCount: 20,
      );
    } catch (e) {
      paletteGenerator = await PaletteGenerator.fromImageProvider(
        const AssetImage('assets/images/noImage.jpg'),
        maximumColorCount: 20,
      );
    }
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

  FutureOr<void> _getMyFollwers(
      MyFollowersGetEvent event, Emitter<UserProfileState> emit) async {
    emit(state.copyWith(
        getMyFollowersRequestStatus: UserDataGetRequestStatus.loading));
    final result = await myFollowersGetUseCase(
        FollowersFollowingParams(accessToken: event.accessToken, page: 1));
    result.fold(
        (l) => emit(state.copyWith(
            statusCode: l.statusCode,
            isEndOfFollowersData: true,
            getMyFollowersRequestStatus: UserDataGetRequestStatus.error,
            errorMessage: l.message)), (r) {
      emit(
        state.copyWith(
            followersData: r,
            statusCode: 0,
            isEndOfFollowersData: r.result < 10 ? true : false,
            getMyFollowersRequestStatus: UserDataGetRequestStatus.success,
            errorMessage: ''),
      );
    });
  }

  FutureOr<void> _getMyFollowing(
      MyFollowingGetEvent event, Emitter<UserProfileState> emit) async {
    emit(state.copyWith(
        getMyFollowingRequestStatus: UserDataGetRequestStatus.loading));
    final result = await myFollowingGetUseCase(
        FollowersFollowingParams(accessToken: event.accessToken, page: 1));
    result.fold(
        (l) => emit(state.copyWith(
            statusCode: l.statusCode,
            getMyFollowingRequestStatus: UserDataGetRequestStatus.error,
            errorMessage: l.message)), (r) {
      emit(state.copyWith(
          followingData: r,
          statusCode: 0,
          isEndOfFollowingData: r.result < 10 ? true : false,
          getMyFollowingRequestStatus: UserDataGetRequestStatus.success,
          errorMessage: ''));
    });
  }

  FutureOr<void> _getMoreFollowers(
      MyFollowersGetMoreEvent event, Emitter<UserProfileState> emit) async {
    final result = await myFollowersGetUseCase(FollowersFollowingParams(
        accessToken: event.accessToken, page: event.page));

    result.fold(
        (l) => emit(state.copyWith(
            statusCode: l.statusCode,
            errorMessage: l.message,
            isEndOfFollowersData: true)), (r) {
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
          statusCode: 0,
          followersData: followersEntitie.copyWith(),
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
    final result = await myFollowingGetUseCase(FollowersFollowingParams(
        accessToken: event.accessToken, page: event.page));
    result.fold(
        (l) => emit(state.copyWith(
            statusCode: l.statusCode,
            errorMessage: l.message,
            isEndOfFollowingData: true)), (r) {
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
          statusCode: 0,
          followingData: followingData.copyWith(),
          isEndOfFollowingData: false,
        ));
      } else {
        OtherUsersDataEntitie followingData = state.followingData!;
        followingData.followerFollowigDataEntite
            .addAll(r.followerFollowigDataEntite);
        emit(state.copyWith(
          errorMessage: '',
          followingData: followingData.copyWith(),
          isEndOfFollowingData: true,
        ));
      }
    });
  }

  FutureOr<void> _pickImage(
      PickImageEvent event, Emitter<UserProfileState> emit) async {
    try {
      final pickkImage = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (pickkImage == null) return;
      emit(
        state.copyWith(
          pickedUserProfileImageFilePath: pickkImage.files.first.path,
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
            statusCode: l.statusCode,
            updateUserPhotoRequestStatus: UpdateUserDataRequestStatus.error)),
        (r) => emit(state.copyWith(
            errorMessage: '',
            statusCode: 0,
            pickedUserProfileImageFilePath: '',
            updateUserPhotoRequestStatus:
                UpdateUserDataRequestStatus.success)));
  }

  FutureOr<void> _passwordHide(
      PasswordHideEvent event, Emitter<UserProfileState> emit) {
    emit(state.copyWith(isPasswordHide: !state.isPasswordHide));
  }
}
