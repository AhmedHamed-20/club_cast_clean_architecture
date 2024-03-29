import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/services/service_locator.dart';
import 'package:club_cast_clean_architecture/core/widgets/error_screen.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/rooms_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utl/utls.dart';
import '../widgets/AllRoomsWidgets/home_main_widget.dart';

class AllRoomsScreen extends StatelessWidget {
  const AllRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => servicelocator<RoomsBloc>()
        ..add(
          AllRoomsGetEvent(
            accessToken: ConstVar.accessToken,
          ),
        ),
      child: BlocBuilder<RoomsBloc, RoomsState>(
        builder: (context, state) {
          switch (state.allRoomsGetRequestStatus) {
            case AllRoomsGetRequestStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case AllRoomsGetRequestStatus.success:
              return const HomeMainWidget();
            case AllRoomsGetRequestStatus.error:
              if (state.statusCode == 403 || state.statusCode == 401) {
                return ErrorScreen(
                  isHoleScreen: false,
                  message: state.errorMessage,
                  statusCode: state.statusCode,
                );
              } else {
                return ErrorScreen(
                  isHoleScreen: false,
                  message: state.errorMessage,
                  onRetry: () {
                    BlocProvider.of<RoomsBloc>(context).add(
                      AllRoomsGetEvent(accessToken: ConstVar.accessToken),
                    );
                  },
                );
              }
          }
        },
      ),
    );
  }
}
