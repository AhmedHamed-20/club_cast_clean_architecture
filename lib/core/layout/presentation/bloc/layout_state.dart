part of 'layout_bloc.dart';

class LayoutState extends Equatable {
  final UserDataEntitie? userDataEntitie;
  final String errorMessage;
  final UserDataGetRequestStatus userDataGetRequestStatus;

  const LayoutState(
      {this.userDataEntitie,
      this.errorMessage = '',
      this.userDataGetRequestStatus = UserDataGetRequestStatus.loading});

  LayoutState copyWith({
    UserDataEntitie? userDataEntitie,
    String? errorMessage,
    UserDataGetRequestStatus? userDataGetRequestStatus,
  }) {
    return LayoutState(
      userDataEntitie: userDataEntitie ?? this.userDataEntitie,
      errorMessage: errorMessage ?? this.errorMessage,
      userDataGetRequestStatus:
          userDataGetRequestStatus ?? this.userDataGetRequestStatus,
    );
  }

  @override
  List<Object?> get props =>
      [userDataGetRequestStatus, userDataEntitie, errorMessage];
}
