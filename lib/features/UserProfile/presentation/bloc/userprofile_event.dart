part of 'userprofile_bloc.dart';

abstract class UserprofileEvent extends Equatable {
  const UserprofileEvent();
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
  final int page;
  const MyFollowingGetMoreEvent(this.accessToken, this.page);

  @override
  List<Object?> get props => [accessToken, page];
}

class MyFollowersGetMoreEvent extends UserprofileEvent {
  final String accessToken;
  final int page;
  const MyFollowersGetMoreEvent(this.accessToken, this.page);

  @override
  List<Object?> get props => [accessToken, page];
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

class PasswordHideEvent extends UserprofileEvent {
  final bool isHidden;
  const PasswordHideEvent(this.isHidden);

  @override
  List<Object?> get props => [isHidden];
}
