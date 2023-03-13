import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/data/datasource/remote_data_source_common_playing_podcast.dart';
import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/data/repository/common_playing_podcast_repository_impl.dart';
import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/domain/repository/base_commo_podcast_repository.dart';
import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/domain/usecases/add_like.dart';
import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/domain/usecases/download_podcast.dart';
import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/domain/usecases/get_podcast_likes_users.dart';
import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/domain/usecases/remove_like.dart';
import 'package:club_cast_clean_architecture/core/layout/data/datasources/layout_local_data_source_impl.dart';
import 'package:club_cast_clean_architecture/core/layout/data/datasources/layout_remote_data_source_impl.dart';
import 'package:club_cast_clean_architecture/core/layout/data/repositories/layout_repository_impl.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/repositories/base_layout_repository.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/cache_active_color_value.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/cache_active_theme_value.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/cache_app_languages.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_active_user_data.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_cached_access_token.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_cached_app_color_value.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_cached_app_language.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_cached_theme_value.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_categories.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_my_following_events.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/remove_access_token.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/update_cached_access_token.dart';
import 'package:club_cast_clean_architecture/core/layout/presentation/bloc/layout_bloc.dart';
import 'package:club_cast_clean_architecture/features/Auth/data/datasources/auth_local_data_source.dart';
import 'package:club_cast_clean_architecture/features/Auth/data/datasources/auth_remote_data_source.dart';
import 'package:club_cast_clean_architecture/features/Auth/data/repositories/auth_repository.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/repositories/auth_repository.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/cache_access_token.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/forget_password.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/sign_up.dart';
import 'package:club_cast_clean_architecture/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/repositories/podcast_repository.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/add_like.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/get_following_podcast.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/get_more_my_following_podcasts.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/remove_like_by_podcast_id.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/presentation/bloc/podcast_bloc.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/datasources/remote_other_users_data_source.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/repositories/other_user_repository_impl.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/repositories/base_other_user_repository.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/usecases/get_other_user_podcasts.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/usecases/get_user_followers.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/usecases/get_user_profile_data.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/usecases/other_user_events.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/presentation/bloc/otherusersprofiles_bloc.dart';
import 'package:club_cast_clean_architecture/features/Rooms/data/datasources/remote_rooms_data_source.dart';
import 'package:club_cast_clean_architecture/features/Rooms/data/repositories/rooms_repository_impl.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/repositories/base_rooms_repository.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/usecases/get_all_rooms.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/usecases/get_room_by_room_id.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/rooms_bloc.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/chat/chat_bloc.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/voice/sockets_voice_bloc.dart';
import 'package:club_cast_clean_architecture/features/Search/data/datasources/remote_search_data_source.dart';
import 'package:club_cast_clean_architecture/features/Search/data/repositories/search_repository_impl.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/repositories/base_search_repository.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/usecases/all_podcasts.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/usecases/podcast_search.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/usecases/rooms_search.dart';
import 'package:club_cast_clean_architecture/features/Search/domain/usecases/users_search.dart';
import 'package:club_cast_clean_architecture/features/Search/presentation/bloc/search_bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/data/datasources/remote_user_info_data_source_impl.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/data/repositories/user_info_repository_impl.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/repositories/base_user_info_repository.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/events/create_event.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/events/get_my_events.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/events/remove_event.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/events/update_event.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/podcasts/get_my_podcasts.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/podcasts/remove_podcast.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/upload_podcast_usecase/create_podcast.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/upload_podcast_usecase/generate_signature.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/upload_podcast_usecase/upload_podcast.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/get_followers.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/get_following.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/update_password.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/update_user_image.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/update_user_info.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/MyEventsBloc/my_events_bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/MyPodcastBloc/my_podcast_bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/Auth/domain/usecases/login.dart';
import '../../features/MyFollowingPodcasts/data/datasources/pdocast_remote_data_source.dart';
import '../../features/MyFollowingPodcasts/data/repositories/podcast_repository.dart';
import '../../features/OtherUsersProfiles/domain/usecases/follow_user.dart';
import '../../features/OtherUsersProfiles/domain/usecases/get_user_following.dart';
import '../../features/OtherUsersProfiles/domain/usecases/un_follow_user.dart';
import '../../features/Rooms/domain/usecases/get_room_messages.dart';
import '../cache/cache_setup.dart';
import '../common_playing_podcast_feature/presentation/bloc/common_playing_podcast_bloc_bloc.dart';
import '../network/dio.dart';
import '../network/endpoints.dart';

final servicelocator = GetIt.instance;

class ServiceLocator {
  static Future<void> initSharedPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    servicelocator
        .registerLazySingleton<SharedPreferences>(() => sharedPreferences);
    servicelocator.registerLazySingleton<CacheHelper>(
        () => CacheHelper(sharedPreferences: servicelocator()));
  }

  static Future<void> initDio() async {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
    servicelocator.registerLazySingleton<Dio>(() => dio);
    servicelocator
        .registerLazySingleton<DioHelper>(() => DioHelper(servicelocator()));
  }

//socket
  static void init() {
    //assettAudioPlayer

    servicelocator
        .registerFactory<AssetsAudioPlayer>(() => AssetsAudioPlayer());

    ///bloc
    servicelocator.registerFactory<ChatBloc>(() => ChatBloc(servicelocator()));

    servicelocator.registerFactory<AuthBloc>(() => AuthBloc(servicelocator(),
        servicelocator(), servicelocator(), servicelocator()));
    servicelocator.registerFactory<PodcastBloc>(() => PodcastBloc(
          servicelocator(),
          servicelocator(),
        ));

    servicelocator.registerLazySingleton<LayoutBloc>(() => LayoutBloc(
        servicelocator(),
        servicelocator(),
        servicelocator(),
        servicelocator(),
        servicelocator(),
        servicelocator(),
        servicelocator(),
        servicelocator(),
        servicelocator(),
        servicelocator(),
        servicelocator(),
        servicelocator()));

    servicelocator.registerFactory<SocketsVoiceBloc>(() =>
        SocketsVoiceBloc(servicelocator(), servicelocator(), servicelocator()));
    servicelocator.registerFactory<CommonPlayingPodcastBlocBloc>(
        () => CommonPlayingPodcastBlocBloc(
              servicelocator(),
              servicelocator(),
              servicelocator(),
              servicelocator(),
              servicelocator(),
              servicelocator(),
            ));
    servicelocator.registerFactory<UserProfileBloc>(() => UserProfileBloc(
          servicelocator(),
          servicelocator(),
          servicelocator(),
          servicelocator(),
          servicelocator(),
        ));
    servicelocator.registerFactory<MyPodcastBloc>(() => MyPodcastBloc(
          servicelocator(),
          servicelocator(),
          servicelocator(),
          servicelocator(),
          servicelocator(),
        ));
    servicelocator.registerFactory<MyEventsBloc>(() => MyEventsBloc(
          servicelocator(),
          servicelocator(),
          servicelocator(),
          servicelocator(),
        ));
    servicelocator
        .registerFactory<OtherUserProfileBloc>(() => OtherUserProfileBloc(
              servicelocator(),
              servicelocator(),
              servicelocator(),
              servicelocator(),
              servicelocator(),
              servicelocator(),
              servicelocator(),
            ));
    servicelocator.registerFactory<RoomsBloc>(() => RoomsBloc(
          servicelocator(),
          servicelocator(),
        ));

    servicelocator.registerFactory<SearchBloc>(() => SearchBloc(
          servicelocator(),
          servicelocator(),
          servicelocator(),
          servicelocator(),
        ));

    ///usecase
    servicelocator.registerLazySingleton<SignUpUsecase>(
        () => SignUpUsecase(servicelocator()));
    servicelocator.registerLazySingleton<LoginUsecase>(
        () => LoginUsecase(servicelocator()));
    servicelocator.registerLazySingleton<ForgetPasswordUsecase>(
        () => ForgetPasswordUsecase(servicelocator()));

    servicelocator.registerLazySingleton<FollowingPodcastUsecase>(
        () => FollowingPodcastUsecase(servicelocator()));
    servicelocator.registerLazySingleton<PodcastLikesUsersUsecase>(
        () => PodcastLikesUsersUsecase(servicelocator()));
    servicelocator.registerLazySingleton<LikeAddByIdUsecase>(
        () => LikeAddByIdUsecase(servicelocator()));
    servicelocator.registerLazySingleton<LikeRemoveByPodcastIdUsecase>(
        () => LikeRemoveByPodcastIdUsecase(servicelocator()));
    servicelocator.registerLazySingleton<ActiveUserDataGetUseCase>(
        () => ActiveUserDataGetUseCase(servicelocator()));
    servicelocator.registerLazySingleton<UserDataUpdateUseCase>(
        () => UserDataUpdateUseCase(servicelocator()));
    servicelocator.registerLazySingleton<SignatureGenerateUsecase>(
        () => SignatureGenerateUsecase(servicelocator()));
    servicelocator.registerLazySingleton<PodcastUploadUsecase>(
        () => PodcastUploadUsecase(servicelocator()));
    servicelocator.registerLazySingleton<PodcastCreateUseCase>(
        () => PodcastCreateUseCase(servicelocator()));
    servicelocator.registerLazySingleton<MyPodcastsGetUseCase>(
        () => MyPodcastsGetUseCase(servicelocator()));
    servicelocator.registerLazySingleton<PasswordUpdateUseCase>(
        () => PasswordUpdateUseCase(servicelocator()));
    servicelocator.registerLazySingleton<EventCreateUseCase>(
        () => EventCreateUseCase(servicelocator()));
    servicelocator.registerLazySingleton<MyEventsGetUsecase>(
        () => MyEventsGetUsecase(servicelocator()));
    servicelocator.registerLazySingleton<AccessTokenCacheUsecase>(
        () => AccessTokenCacheUsecase(servicelocator()));
    servicelocator.registerLazySingleton<CachedAccessTokenGetUsecase>(
        () => CachedAccessTokenGetUsecase(servicelocator()));
    servicelocator.registerLazySingleton<MyFollowingEventsUsecase>(
        () => MyFollowingEventsUsecase(servicelocator()));
    servicelocator.registerLazySingleton<MoreMyFollowingPodcastsUsecase>(
        () => MoreMyFollowingPodcastsUsecase(servicelocator()));
    servicelocator.registerLazySingleton<PodcastDownloadUsecase>(
        () => PodcastDownloadUsecase(servicelocator()));
    servicelocator.registerLazySingleton<LikeAddMyPodcastsUsecast>(
        () => LikeAddMyPodcastsUsecast(servicelocator()));
    servicelocator.registerLazySingleton<LikeRemoveMyPodcastsUsecast>(
        () => LikeRemoveMyPodcastsUsecast(servicelocator()));

    servicelocator.registerLazySingleton<MyFollowingGetUseCase>(
        () => MyFollowingGetUseCase(servicelocator()));
    servicelocator.registerLazySingleton<MyFollowersGetUseCase>(
        () => MyFollowersGetUseCase(servicelocator()));
    servicelocator.registerLazySingleton<PodcastRemoveUsecase>(
        () => PodcastRemoveUsecase(servicelocator()));

    servicelocator.registerLazySingleton<EventRemoveUsecase>(
        () => EventRemoveUsecase(servicelocator()));
    servicelocator.registerLazySingleton<EventUpdateUsecase>(
        () => EventUpdateUsecase(servicelocator()));
    servicelocator.registerLazySingleton<CategoriesGetUsecase>(
        () => CategoriesGetUsecase(servicelocator()));
    servicelocator.registerLazySingleton<UpdateUserImageUsecase>(
        () => UpdateUserImageUsecase(servicelocator()));
    servicelocator.registerLazySingleton<CachedAccessTokenUpdateUsecase>(
        () => CachedAccessTokenUpdateUsecase(servicelocator()));
    servicelocator.registerLazySingleton<AccessTokenRemoveUsecase>(
        () => AccessTokenRemoveUsecase(servicelocator()));
    servicelocator.registerLazySingleton<OtherUserProfileDataGetUsecase>(
        () => OtherUserProfileDataGetUsecase(servicelocator()));

    servicelocator.registerLazySingleton<OtherUserFollowersUsecase>(
        () => OtherUserFollowersUsecase(servicelocator()));
    servicelocator.registerLazySingleton<OtherUserFollowingUsecase>(
        () => OtherUserFollowingUsecase(servicelocator()));
    servicelocator.registerLazySingleton<OtherUserPodcastUsecase>(
        () => OtherUserPodcastUsecase(servicelocator()));

    servicelocator.registerLazySingleton<OtherUserFollowUsecase>(
        () => OtherUserFollowUsecase(servicelocator()));

    servicelocator.registerLazySingleton<OtherUserUnFollowUsecase>(
        () => OtherUserUnFollowUsecase(servicelocator()));
    servicelocator.registerLazySingleton<OtherUserEventsUsecase>(
        () => OtherUserEventsUsecase(servicelocator()));
    servicelocator.registerLazySingleton<AllRoomsGetUsecase>(
        () => AllRoomsGetUsecase(servicelocator()));
    servicelocator.registerLazySingleton<RoomMessagesGetUsecase>(
        () => RoomMessagesGetUsecase(servicelocator()));
    servicelocator.registerLazySingleton<RoomGetByRoomIdUseCase>(
        () => RoomGetByRoomIdUseCase(servicelocator()));
    servicelocator.registerLazySingleton<PodcastSearchUsecase>(
        () => PodcastSearchUsecase(servicelocator()));
    servicelocator.registerLazySingleton<RoomsSearchUsecase>(
        () => RoomsSearchUsecase(servicelocator()));
    servicelocator.registerLazySingleton<UsersSearchUsecase>(
        () => UsersSearchUsecase(servicelocator()));
    servicelocator.registerLazySingleton<AllPodcastsUsecase>(
        () => AllPodcastsUsecase(servicelocator()));
    servicelocator.registerLazySingleton<ThemeDataValueCacheUssecase>(
        () => ThemeDataValueCacheUssecase(servicelocator()));
    servicelocator.registerLazySingleton<GetThemeDataValueFromCacheUssecase>(
        () => GetThemeDataValueFromCacheUssecase(servicelocator()));
    servicelocator.registerLazySingleton<CacheAppColorValueUsecase>(
        () => CacheAppColorValueUsecase(servicelocator()));
    servicelocator
        .registerLazySingleton<GetCachedAppColorValueFromCacheUssecase>(
            () => GetCachedAppColorValueFromCacheUssecase(servicelocator()));
    servicelocator.registerLazySingleton<CacheAppLanguageUsecase>(
        () => CacheAppLanguageUsecase(servicelocator()));
    servicelocator.registerLazySingleton<GetCachedAppLanguageUsecase>(
        () => GetCachedAppLanguageUsecase(servicelocator()));

    ///repository
    servicelocator.registerLazySingleton<BaseAuthRepository>(
        () => AuthRepositoryImple(servicelocator(), servicelocator()));

    servicelocator.registerLazySingleton<BasePodcastRepository>(
        () => PodcastRepositoryImple(servicelocator()));
    servicelocator.registerLazySingleton<BaseLayoutRepository>(
        () => LayoutRepositoryImpl(servicelocator(), servicelocator()));
    servicelocator.registerLazySingleton<BaseUserInfoRepository>(
        () => UserInfoRepositoryImpl(servicelocator()));
    servicelocator.registerLazySingleton<BaseCommonPodcastRepository>(
        () => CommonPlayingPodcastRepositoryImpl(servicelocator()));
    servicelocator.registerLazySingleton<BaseOtherUserProfilesRepository>(
        () => OtherUserProfileRepositoryImpl(servicelocator()));
    servicelocator.registerLazySingleton<BaseRoomsRepository>(
        () => RoomsRepositoryImpl(servicelocator()));
    servicelocator.registerLazySingleton<BaseSearchRepository>(
        () => SearchRepositoryImpl(servicelocator()));

    ///datasource
    servicelocator.registerLazySingleton<BaseAuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl());
    servicelocator.registerLazySingleton<BaseAuthLocalDataSource>(
        () => AuthLocalDataSourceImpl());
    servicelocator.registerLazySingleton<BasePodcastRemoteDataSource>(
        () => PodcastRemoteDataSourceImpl());
    servicelocator.registerLazySingleton<BaseLayoutRemoteDataSource>(
        () => LayoutRemoteDataSourceImpl());
    servicelocator.registerLazySingleton<BaseLayoutLocalDataSource>(
        () => LayoutLocalDataSourceImpl());
    servicelocator.registerLazySingleton<BaseUserInfoRemoteDataSource>(
        () => RemoteUserInfoDataSourceImpl());
    servicelocator.registerLazySingleton<BaseCommonPlayingPodcastDataSource>(
        () => RemoteCommonPlayingPodcastDataSource());
    servicelocator.registerLazySingleton<BaseRemoteOtherUsersDataSorce>(
        () => RemoteOtherUserDataSourceImpl());
    servicelocator.registerLazySingleton<BaseRemoteRoomsDataSource>(
        () => RemoteRoomsDataSourceImpl());
    servicelocator.registerLazySingleton<BaseRemoteSearchDataSoruce>(
        () => RemoteSearchDataSource());
  }
}
