import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/entities/user_data_entitie.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_active_user_data.dart';
import 'package:equatable/equatable.dart';

import '../../../utl/utls.dart';

part 'layout_event.dart';
part 'layout_state.dart';

class LayoutBloc extends Bloc<LayoutEvent, LayoutState> {
  LayoutBloc(this.activeUserDataGetUseCase) : super(const LayoutState()) {
    on<ActiveUserDataGetEvent>(_getActiveUserData);
  }
  final ActiveUserDataGetUseCase activeUserDataGetUseCase;
  FutureOr<void> _getActiveUserData(
      ActiveUserDataGetEvent event, Emitter<LayoutState> emit) async {
    final result = await activeUserDataGetUseCase(
        ActiveUserDataGetParams(event.accessToken));

    result.fold(
      (l) => emit(state.copyWith(
          errorMessage: l.message,
          userDataGetRequestStatus: UserDataGetRequestStatus.error)),
      (r) => emit(
        state.copyWith(
          errorMessage: '',
          userDataEntitie: r,
          userDataGetRequestStatus: UserDataGetRequestStatus.success,
        ),
      ),
    );
  }
}
