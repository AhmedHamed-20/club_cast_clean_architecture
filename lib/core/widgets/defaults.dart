import 'dart:async';

import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/presentation/bloc/common_playing_podcast_bloc_bloc.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/UserProfile/presentation/bloc/MyPodcastBloc/my_podcast_bloc.dart';
import '../../features/UserProfile/presentation/widgets/podcasts/remove_podcast_alert_dialog_widget.dart';
import '../constants/base_podcast_entitie/base_podcast_entitie.dart';
import '../constants/params.dart';
import '../constants/storage_permission_download_path.dart';
import '../routes/app_route_names.dart';

class Defaults {
  static Widget defaultTextFormField({
    TextEditingController? controller,
    TextInputType? keyboardType,
    String? labelText,
    double radius = AppRadius.r10,
    TextStyle? labelStyle,
    Widget? suffixIcon,
    Widget? prefixIcon,
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
    ValueChanged<String>? onSubmit,
    bool obscureText = false,
    int maxLine = 1,
    TextDirection textDirection = TextDirection.ltr,
    required BuildContext context,
  }) {
    return TextFormField(
      cursorColor: Theme.of(context).primaryColor,
      maxLines: maxLine,
      textDirection: textDirection,
      style: Theme.of(context).textTheme.titleMedium,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsetsDirectional.all(AppPadding.p20),
        labelText: labelText,
        labelStyle: labelStyle,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        errorMaxLines: 2,
      ),
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
      onFieldSubmitted: onSubmit,
    );
  }

  static Widget defaultTextButton({
    required VoidCallback onPressed,
    required Widget child,
  }) {
    return TextButton(
      onPressed: onPressed,
      child: child,
    );
  }

  static Widget defaultButton({
    required VoidCallback onPressed,
    String? text,
    bool isUpperCase = false,
    double height = 50,
    double width = double.infinity,
    double radius = 10,
    required BuildContext context,
  }) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
              color: Theme.of(context).secondaryHeaderColor, width: 2),
        ),
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toString().toUpperCase() : '$text',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}

class DefaultPodcastCallBackParams {
  final CommonPlayingPodcastBlocBloc commonPlayingPodcastBloc;
  final BasePodcastEntitie basePodcastEntitie;
  final CommonPlayingPodcastBlocState state;
  final BuildContext context;
  DefaultPodcastCallBackParams(
      {required this.commonPlayingPodcastBloc,
      required this.basePodcastEntitie,
      required this.state,
      required this.context});

  PodcastCardCallBacksParams defaultPodcastCallBackParams({
    MyPodcastBloc? myPodcastBloc,
    required Bloc podcastBloc,
    required dynamic podcastLikeCountChangeEvent,
  }) {
    return PodcastCardCallBacksParams(
      onPressedOnLikeButton: () {
        commonPlayingPodcastBloc.onPressedOnLikeLogic(
          podcastId: basePodcastEntitie.podcastId,
          podcastLocalStatus: state.podcastsLikesStatus,
          serverLikeStatus: basePodcastEntitie.isLiked,
          podcastBloc: podcastBloc,
          podcastCountEvent: podcastLikeCountChangeEvent,
        );
      },
      onPressedOnRemove: myPodcastBloc == null
          ? () {}
          : () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return BlocProvider.value(
                      value: myPodcastBloc,
                      child: RemovePodcastAlertDialogWidget(
                        podcastId: basePodcastEntitie.podcastId,
                        podcastName: basePodcastEntitie.podcastName,
                      ),
                    );
                  });
            },
      onPressedOnCard: () {
        Navigator.of(context).pushNamed(AppRoutesNames.podcastInfoScreen,
            arguments: basePodcastEntitie);
      },
      onPressedOnUserPhoto: () {
        if (basePodcastEntitie.podcastUserInfo.userId != ConstVar.userId) {
          Navigator.of(context).pushNamed(
            AppRoutesNames.otherUserProfileScreen,
            arguments: OtherUserProfileScreenParams(
              basePodcastEntitie.podcastUserInfo.userId,
            ),
          );
        }
      },
      onPressedDownload: () {
        if (currentDownloadingPodcastId == '') {
          downloadProgress = StreamController();
          commonPlayingPodcastBloc.add(PodcastDownloadEvent(
              podcastUrl: basePodcastEntitie.podcastInfo.podcastUrl,
              savedPath: StoragePermissionDownloadPath.getSavedPath(
                      fileName: basePodcastEntitie.podcastName)
                  .path,
              podcastId: basePodcastEntitie.podcastId,
              downloadProgress: downloadProgress));
        }
      },
      onPressedPlay: () {
        commonPlayingPodcastBloc.onPressedOnPlay(
            basePodcastEntitie: basePodcastEntitie);
      },
      onPressedOnLikesCount: () {
        if (basePodcastEntitie.podcastLikesCount != 0) {
          Navigator.pushNamed(context, AppRoutesNames.podcastUsersLikesScreen,
              arguments: LikesUsersScreenParams(
                  podcastId: basePodcastEntitie.podcastId));
        }
      },
    );
  }
}
