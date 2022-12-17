part of 'userprofile_bloc.dart';

abstract class UserprofileEvent extends Equatable {
  const UserprofileEvent();
}

class MyPodcastsGetEvent extends UserprofileEvent {
  final String accessToken;

  const MyPodcastsGetEvent(this.accessToken);
  @override
  List<Object?> get props => [accessToken];
}

class SignatureGenerateEventEvent extends UserprofileEvent {
  final String accessToken;

  const SignatureGenerateEventEvent(this.accessToken);
  @override
  List<Object?> get props => [accessToken];
}
