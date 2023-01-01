import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/text_editing_controllers.dart';
import '../bloc/userprofile_bloc.dart';
import '../widgets/podcasts/pick_file_widget.dart';
import '../widgets/podcasts/picked_podcast_info.dart';
import '../widgets/podcasts/podcast_category_widget.dart';

late CancelToken cancelToken;

class UploadPodcastScreen extends StatelessWidget {
  const UploadPodcastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<UserProfileBloc>(context)
            .add(const ClearPodcastFileEvent());
        TextEditingControllers.uploadPodcastNameController.clear();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: Theme.of(context).iconTheme,
          title: Text(
            'Upload Podcast',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: Column(
              children: [
                Defaults.defaultTextFormField(
                  controller:
                      TextEditingControllers.uploadPodcastNameController,
                  prefixIcon: Icon(
                    Icons.text_fields,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  context: context,
                  labelText: 'Podcast Name',
                  labelStyle: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: AppHeight.h10,
                ),
                const PodcastCategoryWidget(),
                const SizedBox(
                  height: AppHeight.h10,
                ),
                const PickedPodcastInfoWidget(),
                const SizedBox(
                  height: AppHeight.h10,
                ),
                const PickFileButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
