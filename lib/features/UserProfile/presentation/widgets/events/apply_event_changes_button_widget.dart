import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/events/apply_event_changes_button_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utl/utls.dart';
import '../../../domain/entities/my_event_entitie.dart';

class ApplyChangesButtonWidget extends StatelessWidget {
  const ApplyChangesButtonWidget({super.key, required this.myEventEntitie});
  final MyEventEntitie myEventEntitie;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileBloc, UserprofileState>(
      listener: (context, state) {
        if (state.myEventUpdateRequestStatus ==
            MyDataUpdateRequestStatus.updated) {
          flutterToast(
              msg: 'Event Updated',
              backgroundColor: AppColors.toastSuccess,
              textColor: AppColors.white);
          Navigator.of(context).pop();
        } else if (state.myEventUpdateRequestStatus ==
            MyDataUpdateRequestStatus.error) {
          flutterToast(
              msg: state.errorMessage,
              backgroundColor: AppColors.toastError,
              textColor: AppColors.white);
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        switch (state.myEventUpdateRequestStatus) {
          case MyDataUpdateRequestStatus.idle:
            return ApplyEventChangesButtonDesign(
                myEventEntitie: myEventEntitie);
          case MyDataUpdateRequestStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case MyDataUpdateRequestStatus.updated:
            return ApplyEventChangesButtonDesign(
                myEventEntitie: myEventEntitie);
          case MyDataUpdateRequestStatus.error:
            return ApplyEventChangesButtonDesign(
                myEventEntitie: myEventEntitie);
        }
      },
    );
  }
}
