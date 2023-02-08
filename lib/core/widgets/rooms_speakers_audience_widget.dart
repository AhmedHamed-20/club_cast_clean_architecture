import 'package:club_cast_clean_architecture/core/widgets/cached_network_image_circle_photo.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/all_rooms_entitie_data.dart';
import 'package:flutter/material.dart';

class RoomsAudienceSpeakersWidget extends StatelessWidget {
  const RoomsAudienceSpeakersWidget(
      {super.key, required this.allRoomsDataEntitie});
  final AllRoomsDataEntitie allRoomsDataEntitie;
  @override
  Widget build(BuildContext context) {
    if (allRoomsDataEntitie.audience.isNotEmpty) {
      if (allRoomsDataEntitie.audience.length < 3) {
        return Row(
          children: List.generate(
              allRoomsDataEntitie.audience.length,
              (index) => CachedNetworkImageCirclePhoto(
                  photoUrl: allRoomsDataEntitie.audience[index].photo,
                  photoRadius: 30)),
        );
      } else {
        return Row(
          children: List.generate(
              3,
              (index) => CachedNetworkImageCirclePhoto(
                  photoUrl: allRoomsDataEntitie.audience[index].photo,
                  photoRadius: 30)),
        );
      }
    } else {
      if (allRoomsDataEntitie.brodcasters.length < 3) {
        return Row(
          children: List.generate(
              allRoomsDataEntitie.brodcasters.length,
              (index) => CachedNetworkImageCirclePhoto(
                  photoUrl: allRoomsDataEntitie.brodcasters[index].photo,
                  photoRadius: 30)),
        );
      } else {
        return Row(
          children: List.generate(
              3,
              (index) => CachedNetworkImageCirclePhoto(
                  photoUrl: allRoomsDataEntitie.brodcasters[index].photo,
                  photoRadius: 30)),
        );
      }
    }
  }
}
