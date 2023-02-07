import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/widgets/cached_network_image_circle_photo.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/params.dart';
import '../widgets/PrivateChatRoomWidgets/private_chat_room_messages_widget.dart';
import '../widgets/PrivateChatRoomWidgets/private_chat_room_text_field_widget.dart';

class PrivateChatRoomScreen extends StatelessWidget {
  const PrivateChatRoomScreen({super.key, required this.params});
  final PrivateChatRoomScreenParams params;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CachedNetworkImageCirclePhoto(
                photoUrl: params.roomUserDataEntitie.photo, photoRadius: 40),
            SizedBox(width: AppWidth.w10),
            Text(
              params.roomUserDataEntitie.name,
              style: Theme.of(context).textTheme.titleLarge,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          PrivateChatRoomMessagesWidget(params: params),
          PrivateChatRoomTextFieldWidget(userId: params.roomUserDataEntitie.id),
        ],
      ),
    );
  }
}
