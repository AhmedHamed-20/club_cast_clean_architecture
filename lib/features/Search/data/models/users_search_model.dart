import 'package:club_cast_clean_architecture/features/Search/domain/entities/search_users_info_entity.dart';

class SearchUsersModel extends SearchUsersEntity {
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

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': userName,
      'photo': userPhoto,
      '_id': userId,
      'isFollowed': isFollowed
    };
  }

  @override
  List<Object?> get props => [userName, userPhoto, userId, isFollowed];
}
