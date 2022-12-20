part of 'layout_bloc.dart';

class LayoutState extends Equatable {
  final UserDataEntitie? userDataEntitie;
  final String errorMessage;
  final UserDataGetRequestStatus userDataGetRequestStatus;
  final UserDataGetRequestStatus getAccessTokenRequestStatus;
  final List<MyFollowingEventsEntitie> myFollowingEventsEntitie;
  final UserDataGetRequestStatus myFollowingEventsRequestStatus;
  const LayoutState(
      {this.userDataEntitie,
      this.errorMessage = '',
      this.myFollowingEventsEntitie = const [],
      this.myFollowingEventsRequestStatus = UserDataGetRequestStatus.loading,
      this.getAccessTokenRequestStatus = UserDataGetRequestStatus.loading,
      this.userDataGetRequestStatus = UserDataGetRequestStatus.loading});

  LayoutState copyWith({
    List<MyFollowingEventsEntitie>? myFollowingEventsEntitie,
    UserDataGetRequestStatus? myFollowingEventsRequestStatus,
    UserDataGetRequestStatus? getAccessTokenRequestStatus,
    UserDataEntitie? userDataEntitie,
    String? errorMessage,
    UserDataGetRequestStatus? userDataGetRequestStatus,
  }) {
    return LayoutState(
      myFollowingEventsEntitie:
          myFollowingEventsEntitie ?? this.myFollowingEventsEntitie,
      myFollowingEventsRequestStatus:
          myFollowingEventsRequestStatus ?? this.myFollowingEventsRequestStatus,
      getAccessTokenRequestStatus:
          getAccessTokenRequestStatus ?? this.getAccessTokenRequestStatus,
      userDataEntitie: userDataEntitie ?? this.userDataEntitie,
      errorMessage: errorMessage ?? this.errorMessage,
      userDataGetRequestStatus:
          userDataGetRequestStatus ?? this.userDataGetRequestStatus,
    );
  }

  @override
  List<Object?> get props => [
        userDataGetRequestStatus,
        userDataEntitie,
        errorMessage,
        getAccessTokenRequestStatus,
        myFollowingEventsEntitie,
        myFollowingEventsRequestStatus
      ];
}
