import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../features/Rooms/domain/entities/all_rooms_entitie_data.dart';
import '../constants/constants.dart';

class AdminRoomsWidget extends StatelessWidget {
  const AdminRoomsWidget({
    Key? key,
    required this.allRoomsDataEntitie,
  }) : super(key: key);
  final AllRoomsDataEntitie allRoomsDataEntitie;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CachedNetworkImage(
            imageBuilder: (context, imageProvider) {
              return Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              );
            },
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) =>
                Image.asset('assets/images/noImage.jpg'),
            imageUrl: allRoomsDataEntitie.admin.photo),
        SizedBox(
          width: AppWidth.w10,
        ),
        Text(
          allRoomsDataEntitie.admin.name,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Theme.of(context).secondaryHeaderColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          width: AppWidth.w10,
        ),
        Card(
          color: Theme.of(context).colorScheme.background,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.r5)),
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p4),
            child: Text(
              'Host',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child: Text(
            'Recording : ${allRoomsDataEntitie.isRecording ? 'ON' : 'OFF'}',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Theme.of(context).secondaryHeaderColor),
          ),
        ),
      ],
    );
  }
}
