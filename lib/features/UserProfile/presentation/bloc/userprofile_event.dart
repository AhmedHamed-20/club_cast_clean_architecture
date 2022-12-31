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
  const SignatureGenerateEventEvent(this.accessToken, this.filePath);
  @override
  List<Object?> get props => [accessToken, filePath];
}

class UploadPodcastEvent extends UserprofileEvent {
  final String filePath;
  final String accessToken;
  final String timestamp;
  final String cloudName;
  final String apiKey;
  final String signature;

  const UploadPodcastEvent({
    required this.filePath,
    required this.accessToken,
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
        signature,
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
  final String eventTime;
  final String accessToken;

  const EventCreateEvent(
      {required this.eventName,
      required this.eventDescription,
      required this.eventDate,
      required this.eventTime,
      required this.accessToken});

  @override
  List<Object?> get props =>
      [eventDate, eventDescription, eventName, eventTime, accessToken];
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

class LikeAddMyPodcastEvent extends UserprofileEvent {
  final String accessToken;
  final String podcastId;

  const LikeAddMyPodcastEvent(
      {required this.accessToken, required this.podcastId});

  @override
  List<Object?> get props => [accessToken, podcastId];
}

class LikeRemoveMyPodcastEvent extends UserprofileEvent {
  final String accessToken;
  final String podcastId;

  const LikeRemoveMyPodcastEvent(
      {required this.accessToken, required this.podcastId});

  @override
  List<Object?> get props => [accessToken, podcastId];
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
