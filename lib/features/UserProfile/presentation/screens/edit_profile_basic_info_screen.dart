import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/layout/domain/entities/user_data_entitie.dart';
import '../widgets/change_profile_data/change_password_bottom_sheet_widget.dart';
import '../widgets/change_profile_data/update_data_button_widget.dart';
import '../widgets/change_profile_data/update_my_data_text_fields.dart';

class EditUserProfileBasicDataScreen extends StatelessWidget {
  const EditUserProfileBasicDataScreen(
      {super.key, required this.userDataEntitie});
  final UserDataEntitie userDataEntitie;
  @override
  Widget build(BuildContext context) {
    final userProfileBloc = BlocProvider.of<UserProfileBloc>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text(
          'Edit Your Data',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child: Column(
            children: [
              BlocBuilder<UserProfileBloc, UserprofileState>(
                builder: (context, state) => Center(
                  child: CircleAvatar(
                    radius: AppRadius.r70,
                    backgroundImage: state.updatedUserDataInfoEntitie != null
                        ? NetworkImage(
                            state.updatedUserDataInfoEntitie!.userPhoto)
                        : NetworkImage(userDataEntitie.userPhoto),
                  ),
                ),
              ),
              const SizedBox(
                height: AppHeight.h10,
              ),
              UpdateMyDataTextFields(userDataEntitie: userDataEntitie),
              const SizedBox(
                height: AppHeight.h20,
              ),
              const UpdateDataButtonWidget(),
              const SizedBox(
                height: AppHeight.h10,
              ),
              Defaults.defaultButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        backgroundColor: Theme.of(context).backgroundColor,
                        isScrollControlled: true,
                        enableDrag: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppRadius.r22),
                            topRight: Radius.circular(
                              AppRadius.r22,
                            ),
                          ),
                        ),
                        builder: (context) {
                          return BlocProvider.value(
                              value: userProfileBloc,
                              child: const ChangePasswodBottomSheetWidget());
                        });
                  },
                  context: context,
                  text: 'Change Password')
            ],
          ),
        ),
      ),
    );
  }
}
