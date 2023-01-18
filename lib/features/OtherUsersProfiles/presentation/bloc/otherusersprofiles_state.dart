part of 'otherusersprofiles_bloc.dart';

class OtherUserProfileState extends Equatable {
  final OtherUserDataEntitie? otherUserDataEntitie;
  final String errorMessage;
  final int statusCode;
  final UserDataGetRequestStatus userDataGetRequestStatus;

  const OtherUserProfileState(
      {this.otherUserDataEntitie,
      this.errorMessage = '',
      this.statusCode = 0,
      this.userDataGetRequestStatus = UserDataGetRequestStatus.loading});

  OtherUserProfileState copyWith({
    OtherUserDataEntitie? otherUserDataEntitie,
    String? errorMessage,
    int? statusCode,
    UserDataGetRequestStatus? userDataGetRequestStatus,
  }) {
    return OtherUserProfileState(
      otherUserDataEntitie: otherUserDataEntitie ?? this.otherUserDataEntitie,
      errorMessage: errorMessage ?? this.errorMessage,
      statusCode: statusCode ?? this.statusCode,
      userDataGetRequestStatus:
          userDataGetRequestStatus ?? this.userDataGetRequestStatus,
    );
  }

  @override
  List<Object?> get props => [
        otherUserDataEntitie,
        errorMessage,
        statusCode,
        userDataGetRequestStatus
      ];
}
