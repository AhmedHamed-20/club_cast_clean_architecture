import 'package:flutter/material.dart';

import '../../../../features/UserProfile/presentation/widgets/my_profile_data/logout_alert_dialog_widget.dart';
import 'change_theme_bottom_sheet.dart';

class UserProfileAppBarIconsWidget extends StatelessWidget {
  const UserProfileAppBarIconsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return const ThemeChangeBottomSheetWidget();
                });
          },
          icon: const Icon(Icons.settings),
        ),
        IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => const LogoutAlertDialogWidget());
            },
            icon: const Icon(Icons.logout)),
      ],
    );
  }
}
