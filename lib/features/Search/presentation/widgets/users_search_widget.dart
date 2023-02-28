import 'package:club_cast_clean_architecture/core/constants/params.dart';
import 'package:club_cast_clean_architecture/core/routes/app_route_names.dart';
import 'package:club_cast_clean_architecture/core/widgets/error_screen.dart';
import 'package:club_cast_clean_architecture/core/widgets/users_card_widget.dart';
import 'package:club_cast_clean_architecture/features/Search/presentation/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/text_editing_controllers.dart';
import '../../../../core/utl/utls.dart';

class UsersSearchWidget extends StatelessWidget {
  const UsersSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      switch (state.usersSearchRequestStatus) {
        case SearchRequestStatus.idle:
          return Center(
            child: Text('Search for users',
                style: Theme.of(context).textTheme.titleLarge),
          );
        case SearchRequestStatus.loading:
          return const Center(
            child: CircularProgressIndicator(),
          );
        case SearchRequestStatus.success:
          return Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: ListView.builder(
              itemCount: state.usersSearchEntitie.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutesNames.otherUserProfileScreen,
                      arguments: OtherUserProfileScreenParams(
                        state.usersSearchEntitie[index].userId,
                      ),
                    );
                  },
                  child: UserCardWidget(
                    userName: state.usersSearchEntitie[index].userName,
                    userPhoto: state.usersSearchEntitie[index].userPhoto,
                  ),
                );
              },
            ),
          );
        case SearchRequestStatus.error:
          if (state.statusCode == 403 || state.statusCode == 401) {
            return ErrorScreen(
              isHoleScreen: false,
              message: state.errorMessages,
              statusCode: state.statusCode,
            );
          } else {
            return ErrorScreen(
              isHoleScreen: false,
              message: state.errorMessages,
              onRetry: () {
                BlocProvider.of<SearchBloc>(context).add(UsersSearchEvent(
                    accessToken: ConstVar.accessToken,
                    query: TextEditingControllers.searchController.text));
              },
            );
          }
      }
    });
  }
}
