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
