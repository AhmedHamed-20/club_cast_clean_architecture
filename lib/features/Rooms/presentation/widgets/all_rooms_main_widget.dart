import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/media_query_of_methods.dart';
import 'package:club_cast_clean_architecture/core/routes/app_route_names.dart';
import 'package:club_cast_clean_architecture/core/utl/utls.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/rooms_bloc.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/chat/chat_bloc.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/voice/sockets_voice_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/room_card_widget.dart';

bool isEndOfRoomsData = false;
int roomsPage = 2;
bool isInRoom = false;

class AllRoomsMainWidget extends StatefulWidget {
  const AllRoomsMainWidget({super.key});

  @override
  State<AllRoomsMainWidget> createState() => _AllRoomsMainWidgetState();
}

class _AllRoomsMainWidgetState extends State<AllRoomsMainWidget> {
  ScrollController scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    listenToScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    roomsPage = 2;
    isEndOfRoomsData = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoomsBloc, RoomsState>(listener: (context, state) {
      isEndOfRoomsData = state.isEndOfRoomsData;
    }, builder: (context, state) {
      if (state.allRoomsEntitie!.allRoomsDataEntitie.isEmpty) {
        return SizedBox(
          height: MediaQueryOfMethods.getAppHeight(context) * 0.5,
          child: Center(
              child: Text(
            'No Currently Active Rooms ',
            style: Theme.of(context).textTheme.titleLarge,
          )),
        );
      } else {
        return ListView.builder(
            controller: scrollController,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.allRoomsEntitie!.allRoomsDataEntitie.length + 1,
            itemBuilder: (context, index) {
              if (index < state.allRoomsEntitie!.allRoomsDataEntitie.length) {
                return BlocListener<SocketsBloc, SocketsState>(
                  listener: (context, socketState) {
                    if (socketState.connectToSocketRequestStatus ==
                            ConnectToSocketRequestStatus.success &&
                        socketState.joinRoomRequestStatus ==
                            JoinRoomRequestStatus.idle) {
                      BlocProvider.of<SocketsBloc>(context).add(
                        JoinRoomEvent(
                          roomName: state
                              .allRoomsEntitie!.allRoomsDataEntitie[index].name,
                        ),
                      );
                      isInRoom = false;
                    }
                    if (socketState.joinRoomRequestStatus ==
                            JoinRoomRequestStatus.success &&
                        isInRoom == false) {
                      BlocProvider.of<ChatBloc>(context).add(
                        RoomMessagesGetEvent(
                          accessToken: ConstVar.accessToken,
                          roomId: state
                              .allRoomsEntitie!.allRoomsDataEntitie[index].id,
                        ),
                      );
                      Navigator.pushNamed(
                        context,
                        AppRoutesNames.roomScreen,
                      );
                      isInRoom = true;
                    }
                    if (socketState.joinRoomRequestStatus ==
                        JoinRoomRequestStatus.left) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRoutesNames.layoutScreen, (route) => false);
                    }
                  },
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<SocketsBloc>(context).add(
                        ConnectToSocketEvent(
                          ConstVar.accessToken,
                        ),
                      );
                    },
                    child: RoomsCardWidget(
                        allRoomsDataEntitie:
                            state.allRoomsEntitie!.allRoomsDataEntitie[index]),
                  ),
                );
              } else {
                return state.isEndOfRoomsData
                    ? const SizedBox.shrink()
                    : const Padding(
                        padding: EdgeInsets.all(AppPadding.p8),
                        child: Center(child: CircularProgressIndicator()),
                      );
              }
            });
      }
    });
  }

  void listenToScrollController() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          isEndOfRoomsData == false) {
        BlocProvider.of<RoomsBloc>(context).add(AllRoomsGetMoreEvent(
            accessToken: ConstVar.accessToken, page: roomsPage));
        roomsPage++;
      }
    });
  }
}
