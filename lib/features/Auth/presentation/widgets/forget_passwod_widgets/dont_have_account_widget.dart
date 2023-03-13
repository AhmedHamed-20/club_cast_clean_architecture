import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/routes/app_route_names.dart';
import '../../../../../core/widgets/defaults.dart';

class DontHaveAccountWidget extends StatelessWidget {
  const DontHaveAccountWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.dontHaveAnAccount.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Defaults.defaultTextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutesNames.signUpScreen);
          },
          child: Text(
            AppStrings.signUp.tr(),
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Theme.of(context).primaryColor),
          ),
        )
      ],
    );
  }
}
