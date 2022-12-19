import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/my_podcast_entitie.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/updated_user_data_info.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/upload_podcast_usecase/create_podcast.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/upload_podcast_usecase/generate_signature.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/upload_podcast_usecase/upload_podcast.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/update_password.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/update_user_info.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utl/utls.dart';
import '../../domain/usecases/podcasts/get_my_podcasts.dart';

part 'userprofile_event.dart';
part 'userprofile_state.dart';

class UserprofileBloc extends Bloc<UserprofileEvent, UserprofileState> {
  UserprofileBloc(
      this.myPodcastsGetUseCase,
      this.signatureGenerateUsecase,
      this.userDataUpdateUseCase,
      this.podcastCreateUseCase,
      this.passwordUpdateUseCase,
      this.podcastUploadUsecase)
      : super(const UserprofileState()) {
    on<MyPodcastsGetEvent>(_getMyPodcasts);
    on<SignatureGenerateEventEvent>(_generateSignature);
    on<UserDataUpdateEvent>(_updateUserData);
    on<UploadPodcastEvent>(_uploadPodcastToCloud);
    on<CreatePodcastEvent>(_createPodcastInDataBase);
    on<PasswordUpdateEvent>(_updatePassword);
  }
  final MyPodcastsGetUseCase myPodcastsGetUseCase;
  final SignatureGenerateUsecase signatureGenerateUsecase;
  final UserDataUpdateUseCase userDataUpdateUseCase;
  final PodcastUploadUsecase podcastUploadUsecase;
  final PodcastCreateUseCase podcastCreateUseCase;
  final PasswordUpdateUseCase passwordUpdateUseCase;
  FutureOr<void> _getMyPodcasts(
      MyPodcastsGetEvent event, Emitter<UserprofileState> emit) async {
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
      SignatureGenerateEventEvent event, Emitter<UserprofileState> emit) async {
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
      UserDataUpdateEvent event, Emitter<UserprofileState> emit) async {
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
      UploadPodcastEvent event, Emitter<UserprofileState> emit) async {
    final result = await podcastUploadUsecase(
      PodcastUploadParams(
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
          category: r.category,
          publicId: r.publicId,
        ),
      );
    });
  }

  FutureOr<void> _createPodcastInDataBase(
      CreatePodcastEvent event, Emitter<UserprofileState> emit) async {
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
      (r) => emit(
        state.copyWith(
          errorMessage: '',
          uploadPodcastRequestStatus:
              UploadPodcastRequestStatus.podcastCreatedSucess,
        ),
      ),
    );
  }

  FutureOr<void> _updatePassword(
      PasswordUpdateEvent event, Emitter<UserprofileState> emit) async {
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
}
