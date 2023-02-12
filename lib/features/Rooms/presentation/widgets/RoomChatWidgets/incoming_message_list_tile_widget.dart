import 'package:club_cast_clean_architecture/core/widgets/cached_network_image_circle_photo.dart';
import 'package:flutter/material.dart';

class IncomingMessageListTileWidget extends StatelessWidget {
  const IncomingMessageListTileWidget(
      {super.key,
      required this.message,
      required this.userName,
      required this.userPhoto});
  final String message;
  final String userName;
  final String userPhoto;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImageCirclePhoto(
        photoRadius: 30,
        photoUrl: userPhoto,
      ),
      title: Text(
        userName,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      subtitle: Text(
        message,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}
