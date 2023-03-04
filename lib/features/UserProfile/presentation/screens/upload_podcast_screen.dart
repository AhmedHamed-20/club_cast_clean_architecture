import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/MyPodcastBloc/my_podcast_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/ValidationHelper/validation_helper.dart';
import '../../../../core/constants/text_editing_controllers.dart';
import '../widgets/podcasts/pick_file_widget.dart';
import '../widgets/podcasts/picked_podcast_info.dart';
import '../widgets/podcasts/podcast_category_widget.dart';

late CancelToken cancelToken;
final GlobalKey<FormState> uploadPodcastFormKey = GlobalKey<FormState>();

class UploadPodcastScreen extends StatefulWidget {
  const UploadPodcastScreen({super.key});

  @override
  State<UploadPodcastScreen> createState() => _UploadPodcastScreenState();
}

class _UploadPodcastScreenState extends State<UploadPodcastScreen> {
  @override
  void initState() {
    super.initState();
    initControllers();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<MyPodcastBloc>(context)
            .add(const ClearPodcastFileEvent());
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
            child: Form(
              key: uploadPodcastFormKey,
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
                    validator: (value) => ValidationHelper.validateName(
                      value: value,
                      name: 'Podcast Name',
                    ),
                    labelText: 'Podcast Name',
                    labelStyle: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(
                    height: AppHeight.h10,
                  ),
                  const PodcastCategoryWidget(),
                  SizedBox(
                    height: AppHeight.h10,
                  ),
                  const PickedPodcastInfoWidget(),
                  SizedBox(
                    height: AppHeight.h10,
                  ),
                  const PickFileButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void initControllers() {
    TextEditingControllers.uploadPodcastNameController =
        TextEditingController();
  }

  void disposeControllers() {
    TextEditingControllers.uploadPodcastNameController.dispose();
  }
}
