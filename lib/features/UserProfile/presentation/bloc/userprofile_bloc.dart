import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/my_podcast_entitie.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/upload_podcast_usecase/generate_signature.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utl/utls.dart';
import '../../domain/usecases/get_my_podcasts.dart';

part 'userprofile_event.dart';
part 'userprofile_state.dart';

class UserprofileBloc extends Bloc<UserprofileEvent, UserprofileState> {
  UserprofileBloc(this.myPodcastsGetUseCase, this.signatureGenerateUsecase)
      : super(const UserprofileState()) {
    on<MyPodcastsGetEvent>(_getMyPodcasts);
    on<SignatureGenerateEventEvent>(_generateSignature);
  }
  final MyPodcastsGetUseCase myPodcastsGetUseCase;
  final SignatureGenerateUsecase signatureGenerateUsecase;
  FutureOr<void> _getMyPodcasts(
      MyPodcastsGetEvent event, Emitter<UserprofileState> emit) async {
    final result =
        await myPodcastsGetUseCase(MyPodcastGetParams(event.accessToken));
    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            myPodCastequestStatus: MyPodCastequestStatus.error)),
        (r) => emit(state.copyWith(
            errorMessage: '',
            myPodCastequestStatus: MyPodCastequestStatus.success,
            myPodcastEntite: r)));
  }

  FutureOr<void> _generateSignature(
      SignatureGenerateEventEvent event, Emitter<UserprofileState> emit) async {
    final result = await signatureGenerateUsecase(
        SignatureGenerateParams(event.accessToken));
    result.fold(
        (l) => emit(
              state.copyWith(
                errorMessage: l.message,
              ),
            ),
        (r) => null);
  }
}
