import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:club_cast_clean_architecture/core/widgets/error_screen.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/MyPodcastBloc/my_podcast_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/params.dart';
import '../../../../../core/routes/app_route_names.dart';
import '../../../../../core/utl/utls.dart';
import 'main_my_podcast_widget.dart';

class MyPodcastsWidget extends StatelessWidget {
  const MyPodcastsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final myPodcastBloc = BlocProvider.of<MyPodcastBloc>(context);
    return BlocBuilder<MyPodcastBloc, MyPodcastState>(
      builder: (context, state) {
        switch (state.myPodCastRequestStatus) {
          case MyPodCastRequestStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case MyPodCastRequestStatus.success:
            return Padding(
              padding: const EdgeInsets.all(AppPadding.p12),
              child: Column(children: [
                Align(
                  alignment: state.myPodcastEntite.myPodcastDataEntitie.isEmpty
                      ? AlignmentDirectional.center
                      : AlignmentDirectional.centerEnd,
                  child: Defaults.defaultTextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          AppRoutesNames.uploadPodcastScreen,
                          arguments: UploadPodcastScreenParams(myPodcastBloc));
                    },
                    child: Text(
                      AppStrings.uploadPodcast.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                const Expanded(
                  child: MainMyPodcastWidget(),
                ),
              ]),
            );
          case MyPodCastRequestStatus.error:
            if (state.statusCode == 403 || state.statusCode == 401) {
              return ErrorScreen(
                message: state.errorMessage,
                statusCode: state.statusCode,
                isHoleScreen: false,
              );
            } else {
              return ErrorScreen(
                message: state.errorMessage,
                isHoleScreen: false,
                onRetry: () {
                  myPodcastBloc.add(MyPodcastsGetEvent(
                      accessToken: ConstVar.accessToken, page: 1));
                },
              );
            }
        }
      },
    );
  }
}
