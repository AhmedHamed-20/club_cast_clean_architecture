import 'package:club_cast_clean_architecture/core/constants/base_user_info_entitie/basic_follower_data_entity.dart';

class SearchUsersEntity extends BaseFollowerFollowingDataEntity {
  const SearchUsersEntity(
      {required super.userName,
      required super.userPhoto,
      required super.userId,
      required super.isFollowed});

  @override
  List<Object?> get props => [
        super.userName,
        super.userPhoto,
        super.userId,
        super.isFollowed,
      ];
}
