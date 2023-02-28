// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'my_podcast_bloc.dart';

class MyPodcastState extends Equatable {
  final MyPodcastEntitie myPodcastEntite;
  final String errorMessage;
  final int statusCode;
  final bool isEndOfMyPodcastsData;
  final MyPodCastRequestStatus myPodCastRequestStatus;
  final MyDataRemoveRequestStatus myPodCastRemoveRequestStatus;
  final UploadPodcastRequestStatus uploadPodcastRequestStatus;
  final String pickedPodcastFilePath;

  const MyPodcastState({
    this.myPodcastEntite =
        const MyPodcastEntitie(results: 0, myPodcastDataEntitie: []),
    this.errorMessage = '',
    this.statusCode = 0,
    this.isEndOfMyPodcastsData = false,
    this.myPodCastRequestStatus = MyPodCastRequestStatus.loading,
    this.myPodCastRemoveRequestStatus = MyDataRemoveRequestStatus.idle,
    this.uploadPodcastRequestStatus = UploadPodcastRequestStatus.idle,
    this.pickedPodcastFilePath = '',
  });

  MyPodcastState copyWith({
    MyPodcastEntitie? myPodcastEntite,
    String? errorMessage,
    int? statusCode,
    bool? isEndOfMyPodcastsData,
    MyPodCastRequestStatus? myPodCastRequestStatus,
    MyDataRemoveRequestStatus? myPodCastRemoveRequestStatus,
    UploadPodcastRequestStatus? uploadPodcastRequestStatus,
    String? pickedPodcastFilePath,
  }) {
    return MyPodcastState(
      myPodcastEntite: myPodcastEntite ?? this.myPodcastEntite,
      errorMessage: errorMessage ?? this.errorMessage,
      statusCode: statusCode ?? this.statusCode,
      isEndOfMyPodcastsData:
          isEndOfMyPodcastsData ?? this.isEndOfMyPodcastsData,
      myPodCastRequestStatus:
          myPodCastRequestStatus ?? this.myPodCastRequestStatus,
      myPodCastRemoveRequestStatus:
          myPodCastRemoveRequestStatus ?? this.myPodCastRemoveRequestStatus,
      uploadPodcastRequestStatus:
          uploadPodcastRequestStatus ?? this.uploadPodcastRequestStatus,
      pickedPodcastFilePath:
          pickedPodcastFilePath ?? this.pickedPodcastFilePath,
    );
  }

  @override
  List<Object> get props => [
        myPodcastEntite,
        errorMessage,
        statusCode,
        isEndOfMyPodcastsData,
        myPodCastRequestStatus,
        myPodCastRemoveRequestStatus,
        uploadPodcastRequestStatus,
        pickedPodcastFilePath,
      ];
}
