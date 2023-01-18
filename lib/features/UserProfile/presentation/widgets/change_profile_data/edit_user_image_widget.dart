import 'package:cached_network_image/cached_network_image.dart';
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
            return CachedNetworkImage(
                imageBuilder: (context, imageProvider) => Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                errorWidget: (context, url, error) => Image.asset(
                      'assets/images/noImage.jpg',
                      width: 100,
                      height: 100,
                    ),
                imageUrl: layoutState.userDataEntitie!.userPhoto);
          },
        ),
      ),
    );
  }
}
