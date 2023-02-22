import 'package:club_cast_clean_architecture/features/Search/domain/entities/search_users_info_entite.dart';

class SearchUsersModel extends SearchUsersEntite {
  const SearchUsersModel(
      {required super.userName,
      required super.userPhoto,
      required super.userId,
      required super.isFollowed});

  factory SearchUsersModel.fromJson(Map<String, dynamic> json) {
    if (json['follower'] != null) {
      return SearchUsersModel(
          userName: json['follower']['name'],
          userPhoto: json['follower']['photo'],
          userId: json['follower']['_id'],
          isFollowed: json['follower']['isFollowed']);
    } else {
      return SearchUsersModel(
          userName: json['following']['name'],
          userPhoto: json['following']['photo'],
          userId: json['following']['_id'],
          isFollowed: json['following']['isFollowed']);
    }
  }
}
