import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/data/models/my_following_podcast_audio_info_model.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/data/models/my_following_podcast_information_model.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/data/models/my_following_podcast_model.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/data/models/my_following_podcast_user_info_model.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/entities/podcast_entity.dart';
import 'package:dio/dio.dart';

const MyFollowingPodcastEntity tMyFollowingPodcastEntity =
    MyFollowingPodcastEntity(
  results: 1,
  podcastInformationEntitie: [tPodcastInformationModel],
);

const MyFollowingPodcastModel tMyFollowingPodcastModel =
    MyFollowingPodcastModel(
        results: 1, podcastInformationEntitie: [tPodcastInformationModel]);
const PodcastInformationModel tPodcastInformationModel =
    PodcastInformationModel(
  podcastId: 'podcastId',
  podcastName: 'podcastName',
  podcastLikesCount: 1,
  category: 'category',
  createdAt: 'createdAt',
  isLiked: true,
  podcastUserInfo: tPodcastUserInfoModel,
  podcastInfo: tPodcastAudioInfoModel,
);

const PodcastUserInfoModel tPodcastUserInfoModel = PodcastUserInfoModel(
  'userName',
  'userImage',
  'userId',
);
const PodcastAudioInfoModel tPodcastAudioInfoModel =
    PodcastAudioInfoModel(0, 'url');

final DioError tDioError = DioError(
  requestOptions: RequestOptions(path: ''),
  response: Response(requestOptions: RequestOptions(path: ''), data: {
    'message': 'message',
  }),
);
