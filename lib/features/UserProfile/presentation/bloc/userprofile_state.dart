part of 'userprofile_bloc.dart';

class UserprofileState extends Equatable {
  final List<MyPodcastEntite> myPodcastEntite;
  final String errorMessage;
  final MyPodCastequestStatus myPodCastequestStatus;

  const UserprofileState(
      {this.myPodcastEntite = const [],
      this.errorMessage = '',
      this.myPodCastequestStatus = MyPodCastequestStatus.loading});

  UserprofileState copyWith({
    List<MyPodcastEntite>? myPodcastEntite,
    String? errorMessage,
    MyPodCastequestStatus? myPodCastequestStatus,
  }) {
    return UserprofileState(
      myPodcastEntite: myPodcastEntite ?? this.myPodcastEntite,
      errorMessage: errorMessage ?? this.errorMessage,
      myPodCastequestStatus:
          myPodCastequestStatus ?? this.myPodCastequestStatus,
    );
  }

  @override
  List<Object?> get props => [
        myPodCastequestStatus,
        myPodcastEntite,
        errorMessage,
      ];
}
