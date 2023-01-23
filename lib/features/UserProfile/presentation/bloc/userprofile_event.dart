part of 'userprofile_bloc.dart';

abstract class UserprofileEvent extends Equatable {
  const UserprofileEvent();
}

class MyPodcastsGetEvent extends UserprofileEvent {
  final String accessToken;

  const MyPodcastsGetEvent(this.accessToken);
  @override
  List<Object?> get props => [accessToken];
}

class SignatureGenerateEventEvent extends UserprofileEvent {
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

class UploadPodcastEvent extends UserprofileEvent {
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

class CreatePodcastEvent extends UserprofileEvent {
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

class UserDataUpdateEvent extends UserprofileEvent {
  final String accessToken;
  final String name;
  final String email;
  final String bio;

  const UserDataUpdateEvent(
      {required this.accessToken,
      required this.name,
      required this.email,
      required this.bio});

  @override
  List<Object?> get props => [
        accessToken,
        email,
        name,
        bio,
      ];
}

class PasswordUpdateEvent extends UserprofileEvent {
  final String accessToken;
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  const PasswordUpdateEvent(
      {required this.accessToken,
      required this.currentPassword,
      required this.newPassword,
      required this.confirmPassword});

  @override
  List<Object?> get props => [
        accessToken,
        confirmPassword,
        newPassword,
        currentPassword,
      ];
}

class EventCreateEvent extends UserprofileEvent {
  final String eventName;
  final String eventDescription;
  final String eventDate;
  final String accessToken;

  const EventCreateEvent(
      {required this.eventName,
      required this.eventDescription,
      required this.eventDate,
      required this.accessToken});

  @override
  List<Object?> get props =>
      [eventDate, eventDescription, eventName, accessToken];
}

class MyEventsGetEvent extends UserprofileEvent {
  final String accessToken;

  const MyEventsGetEvent(this.accessToken);
  @override
  List<Object?> get props => [accessToken];
}

class BackGroundColorGenerateEvent extends UserprofileEvent {
  final String imageUrl;

  const BackGroundColorGenerateEvent(this.imageUrl);

  @override
  List<Object?> get props => [imageUrl];
}

class MyFollowersGetEvent extends UserprofileEvent {
  final String accessToken;

  const MyFollowersGetEvent(this.accessToken);

  @override
  List<Object?> get props => [accessToken];
}

class MyFollowingGetEvent extends UserprofileEvent {
  final String accessToken;

  const MyFollowingGetEvent(this.accessToken);

  @override
  List<Object?> get props => [accessToken];
}

class MyFollowingGetMoreEvent extends UserprofileEvent {
  final String accessToken;
  final String page;
  const MyFollowingGetMoreEvent(this.accessToken, this.page);

  @override
  List<Object?> get props => [accessToken, page];
}

class MyFollowersGetMoreEvent extends UserprofileEvent {
  final String accessToken;
  final String page;
  const MyFollowersGetMoreEvent(this.accessToken, this.page);

  @override
  List<Object?> get props => [accessToken, page];
}

class PodcastRemoveEvent extends UserprofileEvent {
  final String accessToken;
  final String podcastId;

  const PodcastRemoveEvent(
      {required this.accessToken, required this.podcastId});

  @override
  List<Object?> get props => [accessToken, podcastId];
}

class EventUpdateDataEvent extends UserprofileEvent {
  final String accessToken;
  final String eventId;
  final String eventName;
  final String eventDescription;
  final String eventDate;

  const EventUpdateDataEvent({
    required this.accessToken,
    required this.eventId,
    required this.eventName,
    required this.eventDescription,
    required this.eventDate,
  });

  @override
  List<Object?> get props => [
        accessToken,
        eventId,
        eventName,
        eventDescription,
        eventDate,
      ];
}

class EventRemoveEvent extends UserprofileEvent {
  final String accessToken;
  final String eventId;

  const EventRemoveEvent({required this.accessToken, required this.eventId});

  @override
  List<Object?> get props => [accessToken, eventId];
}

class PickPodcastFileEvent extends UserprofileEvent {
  const PickPodcastFileEvent();

  @override
  List<Object?> get props => [];
}

class ClearPodcastFileEvent extends UserprofileEvent {
  const ClearPodcastFileEvent();

  @override
  List<Object?> get props => [];
}

class PickImageEvent extends UserprofileEvent {
  const PickImageEvent();

  @override
  List<Object?> get props => [];
}

class UserImageUpdateEvent extends UserprofileEvent {
  final String accessToken;
  final String photoUrl;

  const UserImageUpdateEvent(
      {required this.accessToken, required this.photoUrl});

  @override
  List<Object?> get props => [accessToken, photoUrl];
}
