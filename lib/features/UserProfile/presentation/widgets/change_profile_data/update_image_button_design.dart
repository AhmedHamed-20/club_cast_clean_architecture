import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/userprofile_bloc.dart';

class UpdateImageButtonDesign extends StatelessWidget {
  const UpdateImageButtonDesign({super.key, required this.photoPath});
  final String photoPath;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        BlocProvider.of<UserProfileBloc>(context).add(UserImageUpdateEvent(
            accessToken: ConstVar.accessToken, photoUrl: photoPath));
      },
      child: Text(
        'Update',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
