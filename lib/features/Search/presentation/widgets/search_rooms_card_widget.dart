import 'package:club_cast_clean_architecture/core/widgets/error_screen.dart';
import 'package:club_cast_clean_architecture/core/widgets/room_card_widget.dart';
import 'package:club_cast_clean_architecture/features/Search/presentation/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/text_editing_controllers.dart';
import '../../../../core/utl/utls.dart';

class RoomsSearchWidget extends StatelessWidget {
  const RoomsSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      switch (state.roomsSearchRequestStatus) {
        case SearchRequestStatus.idle:
          return Center(
            child: Text('Search for rooms',
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
              itemCount: state.roomsSearchEntitie.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: RoomsCardWidget(
                    allRoomsDataEntitie: state.roomsSearchEntitie[index],
                  ),
                );
              },
            ),
          );
        case SearchRequestStatus.error:
          if (state.statusCode == 403 || state.statusCode == 401) {
            return ErrorScreen(
              message: state.errorMessages,
              statusCode: state.statusCode,
            );
          } else {
            return ErrorScreen(
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
