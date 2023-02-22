import 'package:club_cast_clean_architecture/features/Search/domain/entities/search_users_info_entite.dart';

class SearchUsersModel extends SearchUsersEntite {
  const SearchUsersModel(
      {required super.userName,
      required super.userPhoto,
      required super.userId,
      required super.isFollowed});

  factory SearchUsersModel.fromJson(Map<String, dynamic> json) {
    return SearchUsersModel(
        userName: json['name'],
        userPhoto: json['photo'],
        userId: json['_id'],
        isFollowed: json['isFollowed']);
  }
}
