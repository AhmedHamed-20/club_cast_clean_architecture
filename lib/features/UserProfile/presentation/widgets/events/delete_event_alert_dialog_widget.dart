import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/MyEventsBloc/my_events_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utl/utls.dart';

class DeleteEventAlertDialogWidget extends StatelessWidget {
  const DeleteEventAlertDialogWidget({
    Key? key,
    required this.eventId,
  }) : super(key: key);
  final String eventId;
  @override
  Widget build(BuildContext context) {
    final myEventsBloc = BlocProvider.of<MyEventsBloc>(context);
    return BlocListener<MyEventsBloc, MyEventsState>(
      listener: (context, state) {
        if (state.myEventRemoveRequestStatus ==
            MyDataRemoveRequestStatus.removed) {
          flutterToast(
              msg: AppStrings.eventRemoved.tr(),
              backgroundColor: AppColors.toastSuccess,
              textColor: AppColors.white);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        } else if (state.myEventRemoveRequestStatus ==
            MyDataRemoveRequestStatus.error) {
          flutterToast(
              msg: state.errorMessages,
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
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          AppStrings.deleteEvent.tr(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(
          AppStrings.areYouSureYouWantToDeleteThisEvent.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              AppStrings.cancel.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          TextButton(
            onPressed: () {
              myEventsBloc.add(EventRemoveEvent(
                  accessToken: ConstVar.accessToken, eventId: eventId));
            },
            child: Text(
              AppStrings.delete.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ],
      ),
    );
  }
}
