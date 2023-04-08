import 'package:club_cast_clean_architecture/features/Rooms/data/models/all_rooms_user_data.dart';
import 'package:club_cast_clean_architecture/features/Search/data/models/podcast_audio_info_model.dart';
import 'package:club_cast_clean_architecture/features/Search/data/models/podcast_search_data_model.dart';
import 'package:club_cast_clean_architecture/features/Search/data/models/podcast_search_model.dart';
import 'package:club_cast_clean_architecture/features/Search/data/models/podcast_search_user_info_model.dart';
import 'package:club_cast_clean_architecture/features/Search/data/models/rooms__search_model.dart';
import 'package:club_cast_clean_architecture/features/Search/data/models/users_search_model.dart';
import 'package:dio/dio.dart';

final Response tPodcastSearchResponse = Response(
  requestOptions: RequestOptions(path: 'path'),
  data: tPodcastSearchModel.toJson(),
  statusCode: 200,
);

const PodcastSearchModel tPodcastSearchModel = PodcastSearchModel(
    results: 1, podcastInformationEntitie: [tPodcastSearchDataModel]);

const PodcastSearchDataModel tPodcastSearchDataModel = PodcastSearchDataModel(
    podcastId: 'id',
    podcastName: 'name',
    podcastLikesCount: 1,
    category: 'category',
    createdAt: 'createdAt',
    isLiked: true,
    podcastUserInfo: tPodcastUserInfoModel,
    podcastInfo: tPodcastAudioInfoModel);

const PodcastSearchUserInfoModel tPodcastUserInfoModel =
    PodcastSearchUserInfoModel(
  'name',
  'image',
  'id',
);

const PodcastAudioSearchInfoModel tPodcastAudioInfoModel =
    PodcastAudioSearchInfoModel(
  1,
  'image',
);

const SearchRoomsModel tSearchRoomsModel = SearchRoomsModel(
  id: 'id',
  name: 'name',
  isRecording: true,
  category: 'category',
  createdAt: 'createdAt',
  admin: tRoomsUserDataModel,
  audience: [tRoomsUserDataModel],
  brodcasters: [tRoomsUserDataModel],
);

const RoomsUserDataModel tRoomsUserDataModel =
    RoomsUserDataModel(id: 'id', name: 'name', photo: 'https', uid: 1);
const SearchUsersModel tSearchUsersModel = SearchUsersModel(
  userId: 'id',
  userName: 'name',
  userPhoto: 'photo',
  isFollowed: true,
);
