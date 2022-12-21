import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/defaults.dart';

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
          'Don\'t have an account ?',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Defaults.defaultTextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutesNames.signUpScreen);
          },
          child: Text(
            'SignUp',
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
