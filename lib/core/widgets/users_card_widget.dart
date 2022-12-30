import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';

class UserCardWidget extends StatelessWidget {
  const UserCardWidget(
      {super.key,
      required this.userName,
      required this.userPhoto,
      this.createdAt});
  final String userName;
  final String userPhoto;
  final String? createdAt;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: AppRadius.r40,
        backgroundImage: NetworkImage(userPhoto),
      ),
      title: Text(
        userName,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: createdAt != null
          ? Text(
              DateTimeFormat.format(
                DateTime.parse(createdAt!).toLocal(),
                format: 'D, M j, H:i',
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
