import 'dart:async';

import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/text_editing_controllers.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/MyPodcastBloc/my_podcast_bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/screens/upload_podcast_screen.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/podcasts/podcast_category_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utl/utls.dart';
import '../../../../../core/widgets/defaults.dart';

class PickedPodcastInfoWidget extends StatelessWidget {
  const PickedPodcastInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myPodcastBloc = BlocProvider.of<MyPodcastBloc>(context);
    return BlocConsumer<MyPodcastBloc, MyPodcastState>(
        listener: (context, state) {
      if (state.uploadPodcastRequestStatus ==
          UploadPodcastRequestStatus.podcastCreatedSucess) {
        flutterToast(
            msg: 'Podcast Uploaded',
            backgroundColor: AppColors.toastSuccess,
            textColor: AppColors.white);
        myPodcastBloc.add(const ClearPodcastFileEvent());
        uploadProgress.close();
        Navigator.pop(context);
      } else if (state.uploadPodcastRequestStatus ==
          UploadPodcastRequestStatus.error) {
        if (cancelToken.isCancelled) {
          flutterToast(
              msg: 'Upload Cancelled',
              backgroundColor: AppColors.toastSuccess,
              textColor: AppColors.white);
          myPodcastBloc.add(const ClearPodcastFileEvent());
          uploadProgress.close();
        } else {
          flutterToast(
              msg: 'Podcast Upload Failed',
              backgroundColor: AppColors.toastError,
              textColor: AppColors.white);
          myPodcastBloc.add(const ClearPodcastFileEvent());
          uploadProgress.close();
        }
      }
    }, builder: (context, state) {
      switch (state.uploadPodcastRequestStatus) {
        case UploadPodcastRequestStatus.idle:
          if (state.pickedPodcastFilePath != '') {
            return Column(
              children: [
                Text(
                  state.pickedPodcastFilePath,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                Defaults.defaultButton(
                  onPressed: () {
                    if (uploadPodcastFormKey.currentState!.validate()) {
                      cancelToken = CancelToken();
                      uploadProgress = StreamController<double>();
                      myPodcastBloc.add(SignatureGenerateEventEvent(
                          filePath: state.pickedPodcastFilePath,
                          accessToken: ConstVar.accessToken,
                          podcastCategory: podcastCategoryValue,
                          cancelToken: cancelToken,
                          uploadProgress: uploadProgress,
                          podcastName: TextEditingControllers
                              .uploadPodcastNameController.text));
                    }
                  },
                  context: context,
                  text: 'Upload',
                )
              ],
            );
          } else {
            return const SizedBox.shrink();
          }

        case UploadPodcastRequestStatus.loading:
          return const Center(
            child: CircularProgressIndicator(),
          );
        case UploadPodcastRequestStatus.signatureGetSuccess:
          return Column(
            children: [
              StreamBuilder<double>(
                  stream: uploadProgress.stream,
                  builder: (context, snapshot) {
                    return LinearProgressIndicator(
                      value: snapshot.data,
                    );
                  }),
              const SizedBox(
                height: 10,
              ),
              Defaults.defaultButton(
                  onPressed: () {
                    cancelToken.cancel();
                    cancelToken = CancelToken();
                  },
                  context: context,
                  text: 'Cancel'),
            ],
          );
        case UploadPodcastRequestStatus.podcastUploadedSuccess:
          return const Center(
            child: CircularProgressIndicator(),
          );
        case UploadPodcastRequestStatus.podcastCreatedSucess:
          return const SizedBox.shrink();
        case UploadPodcastRequestStatus.error:
          return const SizedBox.shrink();
      }
    });
  }
}
