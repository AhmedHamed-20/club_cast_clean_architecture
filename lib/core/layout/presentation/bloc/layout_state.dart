part of 'layout_bloc.dart';

class LayoutState extends Equatable {
  final UserDataEntitie? userDataEntitie;
  final String errorMessage;
  final UserDataGetRequestStatus userDataGetRequestStatus;
  final UserDataGetRequestStatus getAccessTokenRequestStatus;

  const LayoutState(
      {this.userDataEntitie,
      this.errorMessage = '',
      this.getAccessTokenRequestStatus = UserDataGetRequestStatus.loading,
      this.userDataGetRequestStatus = UserDataGetRequestStatus.loading});

  LayoutState copyWith({
    UserDataGetRequestStatus? getAccessTokenRequestStatus,
    UserDataEntitie? userDataEntitie,
    String? errorMessage,
    UserDataGetRequestStatus? userDataGetRequestStatus,
  }) {
    return LayoutState(
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
        getAccessTokenRequestStatus
      ];
}
