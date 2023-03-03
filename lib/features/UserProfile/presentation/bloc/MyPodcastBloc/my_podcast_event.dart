part of 'my_podcast_bloc.dart';

abstract class MyPodcastEvent extends Equatable {
  const MyPodcastEvent();
}

class MyPodcastsGetEvent extends MyPodcastEvent {
  final String accessToken;
  final int page;
  const MyPodcastsGetEvent({required this.accessToken, required this.page});
  @override
  List<Object?> get props => [accessToken, page];
}

class PodcastRemoveEvent extends MyPodcastEvent {
  final String accessToken;
  final String podcastId;

  const PodcastRemoveEvent(
      {required this.accessToken, required this.podcastId});

  @override
  List<Object?> get props => [accessToken, podcastId];
}

class CreatePodcastEvent extends MyPodcastEvent {
  final String accessToken;
  final String podcastName;
  final String category;
  final String publicId;

  const CreatePodcastEvent(
      {required this.accessToken,
      required this.podcastName,
      required this.category,
      required this.publicId});

  @override
  List<Object?> get props => [
        accessToken,
        podcastName,
        category,
        publicId,
      ];
}

class SignatureGenerateEventEvent extends MyPodcastEvent {
  final String accessToken;
  final String filePath;
  final String podcastName;
  final String podcastCategory;
  final CancelToken cancelToken;
  final StreamController uploadProgress;
  const SignatureGenerateEventEvent({
    required this.filePath,
    required this.accessToken,
    required this.cancelToken,
    required this.uploadProgress,
    required this.podcastName,
    required this.podcastCategory,
  });
  @override
  List<Object?> get props => [
        accessToken,
        filePath,
        podcastName,
        cancelToken,
        uploadProgress,
        podcastCategory
      ];
}

class UploadPodcastEvent extends MyPodcastEvent {
  final String filePath;
  final String accessToken;
  final int timestamp;
  final String podcastCategory;
  final StreamController uploadProgress;
  final String podcastName;
  final CancelToken cancelToken;
  final String cloudName;
  final String apiKey;
  final String signature;

  const UploadPodcastEvent({
    required this.filePath,
    required this.podcastCategory,
    required this.accessToken,
    required this.cancelToken,
    required this.uploadProgress,
    required this.podcastName,
    required this.timestamp,
    required this.cloudName,
    required this.apiKey,
    required this.signature,
  });

  @override
  List<Object?> get props => [
        filePath,
        accessToken,
        timestamp,
        cloudName,
        apiKey,
        podcastCategory,
        signature,
        cancelToken,
        uploadProgress,
        podcastName,
      ];
}

class PickPodcastFileEvent extends MyPodcastEvent {
  const PickPodcastFileEvent();

  @override
  List<Object?> get props => [];
}

class ClearPodcastFileEvent extends MyPodcastEvent {
  const ClearPodcastFileEvent();

  @override
  List<Object?> get props => [];
}

class MyPodcastGetMoreEvents extends MyPodcastEvent {
  final String accessToken;
  final int page;

  const MyPodcastGetMoreEvents({required this.accessToken, required this.page});

  @override
  List<Object?> get props => [accessToken, page];
}

class UpdatePodcastLikesCountEvent extends MyPodcastEvent {
  final String podcastId;
  final bool isLiked;

  const UpdatePodcastLikesCountEvent(
      {required this.podcastId, required this.isLiked});

  @override
  List<Object?> get props => [podcastId, isLiked];
}
