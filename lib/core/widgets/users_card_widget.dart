import 'package:cached_network_image/cached_network_image.dart';
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
      leading: CachedNetworkImage(
        imageUrl: userPhoto,
        imageBuilder: (context, imageProvider) => Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => Container(
          width: 50.0,
          height: 50.0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/images/noImage.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
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
              style: Theme.of(context).textTheme.titleSmall,
            )
          : const SizedBox.shrink(),
    );
  }
}
