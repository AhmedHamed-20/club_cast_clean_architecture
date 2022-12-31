import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utl/utls.dart';
import '../bloc/userprofile_bloc.dart';

class DeleteEventAlertDialogWidget extends StatelessWidget {
  const DeleteEventAlertDialogWidget({
    Key? key,
    required this.eventId,
  }) : super(key: key);
  final String eventId;
  @override
  Widget build(BuildContext context) {
    final userProfileBloc = BlocProvider.of<UserProfileBloc>(context);
    return BlocListener<UserProfileBloc, UserprofileState>(
      listener: (context, state) {
        if (state.myEventRemoveRequestStatus ==
            MyDataRemoveRequestStatus.removed) {
          flutterToast(
              msg: 'Event Removed',
              backgroundColor: AppColors.toastSuccess,
              textColor: AppColors.white);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        } else if (state.myEventRemoveRequestStatus ==
            MyDataRemoveRequestStatus.error) {
          flutterToast(
              msg: state.errorMessage,
              backgroundColor: AppColors.toastError,
              textColor: AppColors.white);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.r12),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          'Delete Event',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(
          'Are you sure you want to delete this event?',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          TextButton(
            onPressed: () {
              userProfileBloc.add(EventRemoveEvent(
                  accessToken: ConstVar.accessToken, eventId: eventId));
            },
            child: Text(
              'Delete',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ],
      ),
    );
  }
}
