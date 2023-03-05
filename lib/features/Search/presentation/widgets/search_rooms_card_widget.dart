import 'package:club_cast_clean_architecture/core/widgets/error_screen.dart';
import 'package:club_cast_clean_architecture/core/widgets/room_card_widget.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/voice/sockets_voice_bloc.dart';
import 'package:club_cast_clean_architecture/features/Search/presentation/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/text_editing_controllers.dart';
import '../../../../core/utl/utls.dart';
import '../../../../core/widgets/joining_room_loading_alert_dialog.dart';
import '../../../Rooms/presentation/bloc/sockets/chat/chat_bloc.dart';
import '../../../Rooms/presentation/widgets/AllRoomsWidgets/all_rooms_main_widget.dart';

class RoomsSearchWidget extends StatelessWidget {
  const RoomsSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final chatBloc = BlocProvider.of<ChatBloc>(context);
    final socketsVoiceBloc = BlocProvider.of<SocketsVoiceBloc>(context);
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
                return BlocConsumer<SocketsVoiceBloc, SocketsVoiceState>(
                  listener: (context, socketVoiceState) {
                    if (socketVoiceState.connectToSocketRequestStatus ==
                            ConnectToSocketRequestStatus.success &&
                        socketVoiceState.joinRoomRequestStatus ==
                            JoinRoomRequestStatus.idle) {
                      isIuserInRoom = false;
                      showDialog(
                          context: context,
                          builder: (context) =>
                              const JoiningRoomAlertLoadingDialog());
                    }

                    if (socketVoiceState.joinRoomRequestStatus ==
                        JoinRoomRequestStatus.left) {
                      isIuserInRoom = false;
                    }
                  },
                  builder: (context, socketVoiceState) => InkWell(
                    onTap: () {
                      checkOnTabOnRoomCardLogic(
                        joinCreateRoomEntitie:
                            socketVoiceState.joinCreateRoomEntitie,
                        tabedCardRoomId: state.roomsSearchEntitie[index].id,
                        context: context,
                        isCreateRoom: socketVoiceState.isCreateRoom,
                        chatBloc: chatBloc,
                        socketsVoiceBloc: socketsVoiceBloc,
                        accessToken: ConstVar.accessToken,
                        roomName: state.roomsSearchEntitie[index].name,
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: index == state.roomsSearchEntitie.length
                              ? AppPadding.p60
                              : 0),
                      child: RoomsCardWidget(
                        allRoomsDataEntitie: state.roomsSearchEntitie[index],
                      ),
                    ),
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
