import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/media_query_of_methods.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/change_profile_data/update_passwod_text_fields.dart';
import 'package:flutter/material.dart';

class ChangePasswodBottomSheetWidget extends StatelessWidget {
  const ChangePasswodBottomSheetWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: AppPadding.p12,
          right: AppPadding.p12,
          top: AppPadding.p12,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: MediaQueryOfMethods.getAppHeight(context) * 0.6,
        child: Column(
          children: [
            Text(
              'Update Your Password',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: AppHeight.h10,
            ),
            const UpdatePasswordTextFields(),
          ],
        ),
      ),
    );
  }
}
