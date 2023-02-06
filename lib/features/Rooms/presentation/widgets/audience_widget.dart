import 'package:club_cast_clean_architecture/features/Rooms/presentation/widgets/user_circle_room_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/sockets/voice/sockets_voice_bloc.dart';

class AudienceWidget extends StatelessWidget {
  const AudienceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocketsBloc, SocketsState>(
      builder: (context, state) => SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return UserCircleRoomWidget(
              baseRoomUserDataEntitie: state.audienceEntitie!.audience[index],
            );
          },
          childCount: state.audienceEntitie!.audience.length,
        ),
      ),
    );
  }
}
