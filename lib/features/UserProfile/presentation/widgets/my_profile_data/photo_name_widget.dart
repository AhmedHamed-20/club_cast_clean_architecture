import 'package:club_cast_clean_architecture/core/layout/domain/entities/user_data_entitie.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/media_query_of_methods.dart';

class PhotoAndNameWidget extends StatelessWidget {
  const PhotoAndNameWidget({Key? key, required this.userDataEntitie})
      : super(key: key);
  final UserDataEntitie userDataEntitie;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<UserProfileBloc, UserprofileState>(
          builder: (context, userProfileState) => Container(
            width: MediaQueryOfMethods.getAppWidth(context),
            height: MediaQueryOfMethods.getAppHeight(context) * 0.3,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: userProfileState.backGroundColors.first.color,
                  blurRadius: 50,
                  spreadRadius: 5,
                  offset: const Offset(0, -20),
                ),
                BoxShadow(
                  color: Theme.of(context).backgroundColor.withOpacity(0.5),
                  blurRadius: 50,
                  spreadRadius: 5,
                  offset: const Offset(0, -20),
                ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.r10),
              child: Image.network(
                userDataEntitie.userPhoto,
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
                userDataEntitie.userName,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: AppFontSize.s30),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
