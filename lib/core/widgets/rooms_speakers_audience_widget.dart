import 'package:cached_network_image/cached_network_image.dart';
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
              (index) => CachedNetworkImage(
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: 30,
                      height: 0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    );
                  },
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/images/noImage.jpg'),
                  imageUrl: allRoomsDataEntitie.audience[index].photo)),
        );
      } else {
        return Row(
          children: List.generate(
              3,
              (index) => CachedNetworkImage(
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: 30,
                      height: 0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    );
                  },
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/images/noImage.jpg'),
                  imageUrl: allRoomsDataEntitie.audience[index].photo)),
        );
      }
    } else {
      if (allRoomsDataEntitie.brodcasters.length < 3) {
        return Row(
          children: List.generate(
              allRoomsDataEntitie.brodcasters.length,
              (index) => CachedNetworkImage(
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: 30,
                      height: 0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    );
                  },
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/images/noImage.jpg'),
                  imageUrl: allRoomsDataEntitie.brodcasters[index].photo)),
        );
      } else {
        return Row(
          children: List.generate(
              3,
              (index) => CachedNetworkImage(
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: 30,
                      height: 0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    );
                  },
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/images/noImage.jpg'),
                  imageUrl: allRoomsDataEntitie.brodcasters[index].photo)),
        );
      }
    }
  }
}
