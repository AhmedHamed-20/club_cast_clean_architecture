import 'package:club_cast_clean_architecture/core/widgets/cached_network_image_circle_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/layout/presentation/bloc/layout_bloc.dart';
import '../../bloc/userprofile_bloc.dart';
import 'change_photo_alert_dialog_widget.dart';

class EditUserScreenUserImageWidget extends StatelessWidget {
  const EditUserScreenUserImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProfileBloc = BlocProvider.of<UserProfileBloc>(context);

    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return BlocProvider.value(
                  value: userProfileBloc,
                  child: const ChangePhotoAlertDialogWidget());
            });
      },
      child: Center(
        child: BlocBuilder<LayoutBloc, LayoutState>(
          builder: (context, layoutState) {
            return CachedNetworkImageCirclePhoto(
              photoUrl: layoutState.userDataEntitie!.userPhoto,
              photoRadius: 80,
            );
          },
        ),
      ),
    );
  }
}
