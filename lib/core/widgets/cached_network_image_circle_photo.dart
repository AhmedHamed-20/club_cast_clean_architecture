import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CachedNetworkImageCirclePhoto extends StatelessWidget {
  const CachedNetworkImageCirclePhoto(
      {super.key, required this.photoUrl, required this.photoRadius});
  final String photoUrl;
  final double photoRadius;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageBuilder: (context, imageProvider) => Container(
        width: photoRadius,
        height: photoRadius,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      fit: BoxFit.cover,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      imageUrl: photoUrl,
      errorWidget: (context, url, error) => const CircleAvatar(
        radius: AppRadius.r30,
        backgroundImage: AssetImage(
          'assets/images/noImage.jpg',
        ),
      ),
    );
  }
}
