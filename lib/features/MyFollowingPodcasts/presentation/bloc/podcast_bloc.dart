import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/utl/utls.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/entities/podcast_entitie.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/entities/podcast_likes_users_entitie.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/add_like.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/download_podcast.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/get_following_podcast.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/get_more_my_following_podcasts.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../domain/usecases/get_podcast_likes_users.dart';
import '../../domain/usecases/remove_like_by_podcast_id.dart';

part 'podcast_event.dart';
part 'podcast_state.dart';

class PodcastBloc extends Bloc<PodcastEvent, PodcastState> {
  PodcastBloc(
      this.addLikeUsecase,
      this.followingPodcastUsecase,
      this.podcastLikesUsersUsecase,
      this.removeLikeUsecase,
      this.podcastDownloadUsecase,
      this.moreMyFollowingPodcastsUsecase)
      : super(const PodcastState()) {
    on<GetMyFollowingPodcastsEvent>(_getMyFollowingPodcast);
    on<AddLikeToPodcastEvent>(_addLikeToPodcast);
    on<GetPodcastLikesUsersEvent>(_getPodcastLikesUsers);
    on<RemovePodcastLikeEvent>(_removePodcastLikeAndGetNewData);
    on<MoreMyFollowingPodcastsGetEvent>(_getMoreMyFollowingPodcasts);
    on<PodcastDownloadEvent>(_downloadPodcast);
  }
  final FollowingPodcastUsecase followingPodcastUsecase;
  final MoreMyFollowingPodcastsUsecase moreMyFollowingPodcastsUsecase;

  final PodcastLikesUsersUsecase podcastLikesUsersUsecase;
  final LikeAddByIdUsecase addLikeUsecase;
  final LikeRemoveByPodcastIdUsecase removeLikeUsecase;
  final PodcastDownloadUsecase podcastDownloadUsecase;
  FutureOr<void> _getMyFollowingPodcast(
      GetMyFollowingPodcastsEvent event, Emitter<PodcastState> emit) async {
    final result = await followingPodcastUsecase(
        MyFollowingPodcastParams(event.accessToken));

    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            myFollowingPodcastsRequestStatus:
                MyFollowingPodcastsRequestStatus.error)),
        (r) => emit(state.copyWith(
            errorMessage: '',
            myFollowingPodcasts: r,
            myFollowingPodcastsRequestStatus:
                MyFollowingPodcastsRequestStatus.success)));
  }

  FutureOr<void> _addLikeToPodcast(
      AddLikeToPodcastEvent event, Emitter<PodcastState> emit) async {
    final result = await addLikeUsecase(LikeAddParams(
      event.accessToken,
      event.podcastId,
    ));
    result.fold(
        (l) => emit(state.copyWith(
              errorMessage: l.message,
            )), (r) {
      emit(
        state.copyWith(
          errorMessage: '',
        ),
      );
      add(
        GetMyFollowingPodcastsEvent(
          accessToken: event.accessToken,
        ),
      );
    });
  }

  FutureOr<void> _getPodcastLikesUsers(
      GetPodcastLikesUsersEvent event, Emitter<PodcastState> emit) async {
    emit(state.copyWith(
        myFollowingPodcastsUsersLikesRequestStatus:
            MyFollowingPodcastsUsersLikesRequestStatus.loading));
    final result = await podcastLikesUsersUsecase(
        PodcastLikesUsersparams(event.accessToken, event.podcastId));
    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            myFollowingPodcastsUsersLikesRequestStatus:
                MyFollowingPodcastsUsersLikesRequestStatus.error)),
        (r) => emit(state.copyWith(
            errorMessage: '',
            podcastLikesUsersEntitie: r,
            myFollowingPodcastsUsersLikesRequestStatus:
                MyFollowingPodcastsUsersLikesRequestStatus.success)));
  }

  FutureOr<void> _removePodcastLikeAndGetNewData(
      RemovePodcastLikeEvent event, Emitter<PodcastState> emit) async {
    final result = await removeLikeUsecase(LikeRemoveByPodcastIdParams(
        accessToken: event.accessToken, podcastId: event.podcastId));

    result.fold(
        (l) => emit(state.copyWith(
              errorMessage: l.message,
            )), (r) {
      emit(
        state.copyWith(
          errorMessage: '',
        ),
      );
      add(
        GetMyFollowingPodcastsEvent(
          accessToken: event.accessToken,
        ),
      );
    });
  }

  FutureOr<void> _getMoreMyFollowingPodcasts(
      MoreMyFollowingPodcastsGetEvent event, Emitter<PodcastState> emit) async {
    final result = await moreMyFollowingPodcastsUsecase(
      MoreMyFollowingPodcastParams(
        accessToken: event.accessToken,
        page: event.page,
      ),
    );
    result.fold(
        (l) => emit(state.copyWith(
              errorMessage: l.message,
              moreMyFollowingPodcastsRequestStatus:
                  MyFollowingPodcastsRequestStatus.error,
            )), (r) {
      if (r.results == 0) {
        emit(state.copyWith(
            isEndOfData: true,
            moreMyFollowingPodcastsRequestStatus:
                MyFollowingPodcastsRequestStatus.success));
      } else if (r.results == 10) {
        PodcastEntitie myFollowingPodcastsModel;
        myFollowingPodcastsModel = state.myFollowingPodcasts!;

        myFollowingPodcastsModel.podcastInformationEntitie
            .addAll(r.podcastInformationEntitie);

        emit(state.copyWith(
          errorMessage: '',
          myFollowingPodcasts: myFollowingPodcastsModel,
          isEndOfData: false,
          moreMyFollowingPodcastsRequestStatus:
              MyFollowingPodcastsRequestStatus.success,
        ));
      } else {
        PodcastEntitie myFollowingPodcastsModel = state.myFollowingPodcasts!;
        myFollowingPodcastsModel.podcastInformationEntitie
            .addAll(r.podcastInformationEntitie);
        emit(state.copyWith(
          errorMessage: '',
          myFollowingPodcasts: myFollowingPodcastsModel,
          isEndOfData: true,
          moreMyFollowingPodcastsRequestStatus:
              MyFollowingPodcastsRequestStatus.success,
        ));
      }
    });
  }

  Future<int> getAndroidVersion() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.version.sdkInt;
  }

  Future<bool> checkPermissions() async {
    bool isPermissionGranted = false;
    if (await getAndroidVersion() > 29) {
      if (await Permission.storage.isGranted &&
          await Permission.accessMediaLocation.isGranted &&
          await Permission.manageExternalStorage.isGranted) {
        isPermissionGranted = true;
      } else {
        await Permission.storage.request();
        await Permission.accessMediaLocation.request();
        await Permission.manageExternalStorage.request();
      }
    } else {
      if (await Permission.storage.isGranted &&
          await Permission.accessMediaLocation.isGranted) {
        isPermissionGranted = true;
      } else {
        await Permission.storage.request();
        await Permission.accessMediaLocation.request();
      }
    }
    return isPermissionGranted;
  }

  FutureOr<void> _downloadPodcast(
      PodcastDownloadEvent event, Emitter<PodcastState> emit) async {
    if (await checkPermissions()) {
      emit(state.copyWith(
          podcastDownloadRequestStatus: PodcastDownloadRequestStatus.loading));
      currentDownloadingPodcastId = event.podcastId;
      final result = await podcastDownloadUsecase(PodcastDownloadParams(
          podcastUrl: event.podcastUrl,
          savedPath: event.savedPath,
          receivedData: event.downloadProgress));
      result.fold((l) {
        emit(state.copyWith(
            errorMessage: l.message,
            podcastDownloadRequestStatus: PodcastDownloadRequestStatus.error));
        currentDownloadingPodcastId = '';
        downloadProgress.close();
      }, (r) {
        emit(
          state.copyWith(
            errorMessage: '',
            podcastDownloadRequestStatus:
                PodcastDownloadRequestStatus.downloaded,
          ),
        );
        currentDownloadingPodcastId = '';
        downloadProgress.close();
      });
    } else {
      flutterToast(
          msg: 'Please Accept All Permissions',
          backgroundColor: AppColors.toastError,
          textColor: AppColors.white);
    }
  }

  File getSavedPath({required String podcastName}) {
    final directory = Directory('/storage/emulated/0/Youtube Downloader');
    final removeOrSymbole = podcastName.replaceAll('|', '');
    final fileName = removeOrSymbole.replaceAll('/', '');
    final file = File('${directory.path}/($fileName).mp3');
    return file;
  }
}
