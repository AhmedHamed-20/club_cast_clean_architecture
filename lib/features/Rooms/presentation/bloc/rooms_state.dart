part of 'rooms_bloc.dart';

class RoomsState extends Equatable {
  final AllRoomsEntitie? allRoomsEntitie;
  final AllRoomsGetRequestStatus allRoomsGetRequestStatus;
  final PrivateRoomsGetRequestStatus privateRoomsGetRequestStatus;
  final String errorMessage;
  final int statusCode;
  final bool isEndOfRoomsData;
  const RoomsState(
      {this.allRoomsEntitie,
      this.privateRoomsGetRequestStatus = PrivateRoomsGetRequestStatus.idle,
      this.allRoomsGetRequestStatus = AllRoomsGetRequestStatus.loading,
      this.errorMessage = '',
      this.isEndOfRoomsData = false,
      this.statusCode = 0});
  RoomsState copyWith({
    AllRoomsEntitie? allRoomsEntitie,
    AllRoomsGetRequestStatus? allRoomsGetRequestStatus,
    String? errorMessage,
    PrivateRoomsGetRequestStatus? privateRoomsGetRequestStatus,
    int? statusCode,
    bool? isEndOfRoomsData,
  }) {
    return RoomsState(
      privateRoomsGetRequestStatus:
          privateRoomsGetRequestStatus ?? this.privateRoomsGetRequestStatus,
      allRoomsEntitie: allRoomsEntitie ?? this.allRoomsEntitie,
      allRoomsGetRequestStatus:
          allRoomsGetRequestStatus ?? this.allRoomsGetRequestStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      statusCode: statusCode ?? this.statusCode,
      isEndOfRoomsData: isEndOfRoomsData ?? this.isEndOfRoomsData,
    );
  }

  @override
  List<Object?> get props => [
        privateRoomsGetRequestStatus,
        allRoomsEntitie,
        allRoomsGetRequestStatus,
        errorMessage,
        statusCode,
        isEndOfRoomsData
      ];
}
