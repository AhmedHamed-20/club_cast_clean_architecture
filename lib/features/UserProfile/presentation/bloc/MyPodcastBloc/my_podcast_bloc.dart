import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utl/utls.dart';
import '../../../domain/entities/my_podcast_entite.dart';
import '../../../domain/usecases/podcasts/get_my_podcasts.dart';
import '../../../domain/usecases/podcasts/remove_podcast.dart';
import '../../../domain/usecases/upload_podcast_usecase/create_podcast.dart';
import '../../../domain/usecases/upload_podcast_usecase/generate_signature.dart';
import '../../../domain/usecases/upload_podcast_usecase/upload_podcast.dart';

part 'my_podcast_event.dart';
part 'my_podcast_state.dart';

class MyPodcastBloc extends Bloc<MyPodcastEvent, MyPodcastState> {
  MyPodcastBloc(
      this.myPodcastsGetUseCase,
      this.podcastRemoveUsecase,
      this.podcastCreateUseCase,
      this.signatureGenerateUsecase,
      this.podcastUploadUsecase)
      : super(const MyPodcastState()) {
    on<MyPodcastsGetEvent>(_getMyPodcasts);
    on<PodcastRemoveEvent>(_removePodcast);
    on<CreatePodcastEvent>(_createPodcastInDataBase);
    on<SignatureGenerateEventEvent>(_generateSignature);
    on<UploadPodcastEvent>(_uploadPodcastToCloud);
    on<PickPodcastFileEvent>(_pickPodcastFile);
    on<ClearPodcastFileEvent>(_clearPodcastFile);
  }
  final MyPodcastsGetUseCase myPodcastsGetUseCase;
  final PodcastRemoveUsecase podcastRemoveUsecase;
  final PodcastCreateUseCase podcastCreateUseCase;
  final SignatureGenerateUsecase signatureGenerateUsecase;
  final PodcastUploadUsecase podcastUploadUsecase;

  FutureOr<void> _getMyPodcasts(
      MyPodcastsGetEvent event, Emitter<MyPodcastState> emit) async {
    final result = await myPodcastsGetUseCase(
        MyPodcastGetParams(accessToken: event.accessToken, page: 1));
    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            statusCode: l.statusCode,
            myPodCastRequestStatus: MyPodCastRequestStatus.error)),
        (r) => emit(state.copyWith(
            errorMessage: '',
            statusCode: 0,
            isEndOfMyPodcastsData: r.results < 10 ? true : false,
            myPodCastRequestStatus: MyPodCastRequestStatus.success,
            myPodcastEntite: r)));
  }

  FutureOr<void> _removePodcast(
      PodcastRemoveEvent event, Emitter<MyPodcastState> emit) async {
    emit(state.copyWith(
        myPodCastRemoveRequestStatus: MyDataRemoveRequestStatus.loading));
    final result = await podcastRemoveUsecase(PodcastRemoveParams(
        accessToken: event.accessToken, podcastId: event.podcastId));
    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            statusCode: l.statusCode,
            myPodCastRemoveRequestStatus: MyDataRemoveRequestStatus.error)),
        (r) {
      emit(state.copyWith(
          errorMessage: '',
          statusCode: 0,
          myPodCastRemoveRequestStatus: MyDataRemoveRequestStatus.removed));
      add(MyPodcastsGetEvent(accessToken: event.accessToken, page: 1));
    });
  }

  FutureOr<void> _createPodcastInDataBase(
      CreatePodcastEvent event, Emitter<MyPodcastState> emit) async {
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
            statusCode: l.statusCode,
            errorMessage: l.message,
            uploadPodcastRequestStatus: UploadPodcastRequestStatus.error)),
        (r) {
      emit(
        state.copyWith(
          statusCode: 0,
          errorMessage: '',
          uploadPodcastRequestStatus:
              UploadPodcastRequestStatus.podcastCreatedSucess,
        ),
      );
      add(MyPodcastsGetEvent(accessToken: event.accessToken, page: 1));
    });
  }

  FutureOr<void> _generateSignature(
      SignatureGenerateEventEvent event, Emitter<MyPodcastState> emit) async {
    emit(state.copyWith(
        errorMessage: '',
        uploadPodcastRequestStatus: UploadPodcastRequestStatus.loading));
    final result = await signatureGenerateUsecase(
        SignatureGenerateParams(event.accessToken));
    result.fold(
        (l) => emit(
              state.copyWith(
                errorMessage: l.message,
                statusCode: l.statusCode,
                uploadPodcastRequestStatus: UploadPodcastRequestStatus.error,
              ),
            ), (r) {
      emit(
        state.copyWith(
          errorMessage: '',
          statusCode: 0,
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

  FutureOr<void> _uploadPodcastToCloud(
      UploadPodcastEvent event, Emitter<MyPodcastState> emit) async {
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
            statusCode: l.statusCode,
            uploadPodcastRequestStatus: UploadPodcastRequestStatus.error)),
        (r) {
      emit(
        state.copyWith(
          errorMessage: '',
          statusCode: 0,
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

  FutureOr<void> _pickPodcastFile(
      PickPodcastFileEvent event, Emitter<MyPodcastState> emit) async {
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
      ClearPodcastFileEvent event, Emitter<MyPodcastState> emit) {
    emit(state.copyWith(
        pickedPodcastFilePath: '',
        uploadPodcastRequestStatus: UploadPodcastRequestStatus.idle));
  }
}
