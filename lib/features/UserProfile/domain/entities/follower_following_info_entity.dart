import '../../../../core/constants/base_user_info_entitie/basic_follower_data_entity.dart';

class FollowerFollowigDataEntity extends BaseFollowerFollowingDataEntity {
  const FollowerFollowigDataEntity(
      {required super.userName,
      required super.userPhoto,
      required super.userId,
      required super.isFollowed});

  @override
  List<Object?> get props => [userId, userName, userPhoto, isFollowed];
}
