import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/media_query_of_methods.dart';
import '../../../../../core/layout/presentation/bloc/layout_bloc.dart';

class PhotoAndNameWidget extends StatelessWidget {
  const PhotoAndNameWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.r10),
              child: BlocBuilder<LayoutBloc, LayoutState>(
                builder: (context, layoutState) {
                  return CachedNetworkImage(
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      AssetsPath.noUserImage,
                      width: MediaQueryOfMethods.getAppWidth(context) * 0.5,
                      height: MediaQueryOfMethods.getAppHeight(context) * 0.3,
                      fit: BoxFit.cover,
                    ),
                    imageUrl: layoutState.userDataEntitie!.userPhoto,
                    width: MediaQueryOfMethods.getAppWidth(context) * 0.5,
                    height: MediaQueryOfMethods.getAppHeight(context) * 0.3,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            SizedBox(
              width: AppWidth.w10,
            ),
            Flexible(
              child: BlocBuilder<LayoutBloc, LayoutState>(
                builder: (context, layoutState) {
                  return Text(
                    layoutState.userDataEntitie!.userName,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: AppFontSize.s30),
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
