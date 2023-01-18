import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/presentation/bloc/otherusersprofiles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BioWidget extends StatelessWidget {
  const BioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtherUserProfileBloc, OtherUserProfileState>(
      builder: (context, state) => Text(
        state.otherUserDataEntitie!.bio,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
