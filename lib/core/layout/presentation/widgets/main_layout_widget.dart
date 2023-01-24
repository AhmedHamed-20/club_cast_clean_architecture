import 'package:cached_network_image/cached_network_image.dart';
import 'package:club_cast_clean_architecture/core/layout/presentation/bloc/layout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/constants.dart';
import '../../../constants/media_query_of_methods.dart';

class MainLayoutWidget extends StatelessWidget {
  const MainLayoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final layoutBloc = BlocProvider.of<LayoutBloc>(context);
    return BlocBuilder<LayoutBloc, LayoutState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
          centerTitle: true,
          title: Text(
            layoutBloc.appBarTitles[state.currentBottomNavIndex],
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                    AppRoutesNames.userProfileScreen,
                    arguments: state.userDataEntitie);
              },
              child: CachedNetworkImage(
                imageBuilder: (context, imageProvider) => Container(
                  width: 50,
                  height: 50,
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
                imageUrl: state.userDataEntitie!.userPhoto,
                errorWidget: (context, url, error) => const CircleAvatar(
                  radius: AppRadius.r30,
                  backgroundImage: AssetImage(
                    'assets/images/noImage.jpg',
                  ),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: Theme.of(context).backgroundColor,
            height: MediaQueryOfMethods.getAppHeight(context) * 0.08,
            elevation: AppElevation.eL6,
            indicatorColor: Theme.of(context).primaryColor.withOpacity(0.5),
            iconTheme: MaterialStateProperty.all(
              Theme.of(context).iconTheme.copyWith(size: 20),
            ),
          ),
          child: NavigationBar(
            surfaceTintColor: Theme.of(context).primaryColor,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            elevation: AppElevation.eL4,
            destinations: layoutBloc.bottomNaveIcons,
            backgroundColor: Theme.of(context).backgroundColor,
            selectedIndex: state.currentBottomNavIndex,
            onDestinationSelected: (value) {
              layoutBloc.add(BottomNavIndexChangeEvent(value));
            },
          ),
        ),
        body: layoutBloc.bottomNaveScreens[state.currentBottomNavIndex],
      ),
    );
  }
}
