import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/media_query_of_methods.dart';
import '../bloc/otherusersprofiles_bloc.dart';

class OtherUserProfilePhotoNameWidget extends StatelessWidget {
  const OtherUserProfilePhotoNameWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtherUserProfileBloc, OtherUserProfileState>(
      builder: (context, state) => Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.r10),
            child: CachedNetworkImage(
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Image.asset(
                'assets/images/noImage.jpg',
                width: MediaQueryOfMethods.getAppWidth(context) * 0.5,
                height: MediaQueryOfMethods.getAppHeight(context) * 0.3,
                fit: BoxFit.cover,
              ),
              imageUrl: state.otherUserDataEntitie!.userPhoto,
              width: MediaQueryOfMethods.getAppWidth(context) * 0.5,
              height: MediaQueryOfMethods.getAppHeight(context) * 0.3,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: AppWidth.w10,
          ),
          Flexible(
            child: Text(
              state.otherUserDataEntitie!.userName,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: AppFontSize.s30),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
