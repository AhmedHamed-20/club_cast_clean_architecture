import 'package:equatable/equatable.dart';

class LikesUsersScreenParams extends Equatable {
  final String podcastId;

  const LikesUsersScreenParams({
    required this.podcastId,
  });

  @override
  List<Object?> get props => [podcastId];
}
