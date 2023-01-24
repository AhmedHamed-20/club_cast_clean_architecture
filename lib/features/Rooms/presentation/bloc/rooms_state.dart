part of 'rooms_bloc.dart';

class RoomsState extends Equatable {
  final AllRoomsEntitie? allRoomsEntitie;
  final AllRoomsGetRequestStatus allRoomsGetRequestStatus;
  final String errorMessage;
  final int statusCode;
  final bool isEndOfRoomsData;
  const RoomsState(
      {this.allRoomsEntitie,
      this.allRoomsGetRequestStatus = AllRoomsGetRequestStatus.loading,
      this.errorMessage = '',
      this.isEndOfRoomsData = false,
      this.statusCode = 0});
  RoomsState copyWith({
    AllRoomsEntitie? allRoomsEntitie,
    AllRoomsGetRequestStatus? allRoomsGetRequestStatus,
    String? errorMessage,
    int? statusCode,
    bool? isEndOfRoomsData,
  }) {
    return RoomsState(
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
        allRoomsEntitie,
        allRoomsGetRequestStatus,
        errorMessage,
        statusCode,
        isEndOfRoomsData
      ];
}
