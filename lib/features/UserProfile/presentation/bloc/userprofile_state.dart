part of 'userprofile_bloc.dart';

class UserprofileState extends Equatable {
  final List<MyPodcastEntite> myPodcastEntite;
  final String errorMessage;
  final MyPodCastRequestStatus myPodCastequestStatus;
  final UpdatedUserDataInfoEntitie? updatedUserDataInfoEntitie;
  final UpdateUserDataRequestStatus updateUserDataRequestStatus;
  final UploadPodcastRequestStatus uploadPodcastRequestStatus;
  final UpdateUserDataRequestStatus updatePasswordRequestStatus;
  final EventCreateRequestStatus eventCreateRequestStatus;
  final List<MyEventEntitie> myEvents;
  final UserDataGetRequestStatus myEventRequestStatus;
  const UserprofileState(
      {this.myPodcastEntite = const [],
      this.updatedUserDataInfoEntitie,
      this.myEventRequestStatus = UserDataGetRequestStatus.loading,
      this.myEvents = const [],
      this.eventCreateRequestStatus = EventCreateRequestStatus.idle,
      this.uploadPodcastRequestStatus = UploadPodcastRequestStatus.idle,
      this.updateUserDataRequestStatus = UpdateUserDataRequestStatus.idle,
      this.errorMessage = '',
      this.updatePasswordRequestStatus = UpdateUserDataRequestStatus.idle,
      this.myPodCastequestStatus = MyPodCastRequestStatus.loading});

  UserprofileState copyWith({
    UserDataGetRequestStatus? myEventRequestStatus,
    List<MyEventEntitie>? myEvents,
    EventCreateRequestStatus? eventCreateRequestStatus,
    UpdateUserDataRequestStatus? updatePasswordRequestStatus,
    UploadPodcastRequestStatus? uploadPodcastRequestStatus,
    UpdatedUserDataInfoEntitie? updatedUserDataInfoEntitie,
    UpdateUserDataRequestStatus? updateUserDataRequestStatus,
    List<MyPodcastEntite>? myPodcastEntite,
    String? errorMessage,
    MyPodCastRequestStatus? myPodCastequestStatus,
  }) {
    return UserprofileState(
      myEventRequestStatus: myEventRequestStatus ?? this.myEventRequestStatus,
      myEvents: myEvents ?? this.myEvents,
      eventCreateRequestStatus:
          eventCreateRequestStatus ?? this.eventCreateRequestStatus,
      updatePasswordRequestStatus:
          updatePasswordRequestStatus ?? this.updatePasswordRequestStatus,
      uploadPodcastRequestStatus:
          uploadPodcastRequestStatus ?? this.uploadPodcastRequestStatus,
      updateUserDataRequestStatus:
          updateUserDataRequestStatus ?? this.updateUserDataRequestStatus,
      updatedUserDataInfoEntitie:
          updatedUserDataInfoEntitie ?? this.updatedUserDataInfoEntitie,
      myPodcastEntite: myPodcastEntite ?? this.myPodcastEntite,
      errorMessage: errorMessage ?? this.errorMessage,
      myPodCastequestStatus:
          myPodCastequestStatus ?? this.myPodCastequestStatus,
    );
  }

  @override
  List<Object?> get props => [
        myPodCastequestStatus,
        myEventRequestStatus,
        myEvents,
        eventCreateRequestStatus,
        updatePasswordRequestStatus,
        myPodcastEntite,
        errorMessage,
        updateUserDataRequestStatus,
        updatedUserDataInfoEntitie,
        uploadPodcastRequestStatus,
      ];
}
