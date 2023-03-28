import 'package:club_cast_clean_architecture/core/error/error_message_model.dart';
import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/datasources/remote_other_users_data_source.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/repositories/other_user_repository_impl.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/followers_following_data_entity.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/other_user_event.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/other_user_podcast_entity.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/other_users_data_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../datasources/remote_other_users_dumy_data.dart';

class MockOtherUserRemoteDataSource extends Mock
    implements BaseRemoteOtherUsersDataSorce {}

void main() {
  late MockOtherUserRemoteDataSource mockOtherUserRemoteDataSource;
  late OtherUserProfileRepositoryImpl otherUserProfileRepositoryImpl;
  const ServerException tServerException = ServerException(
      serverErrorMessageModel: ServerErrorMessageModel(message: 'message'));
  setUp(() {
    mockOtherUserRemoteDataSource = MockOtherUserRemoteDataSource();
    otherUserProfileRepositoryImpl =
        OtherUserProfileRepositoryImpl(mockOtherUserRemoteDataSource);
  });
  group('test other users profiles repository impl', () {
    test(
        'getOtherUsersProfiles should return other user data entity on right when success',
        () async {
      // arrange
      when(() => mockOtherUserRemoteDataSource
              .getOtherUsersProfiles(tOtherUserProfileDataSourceParams))
          .thenAnswer((_) async => tOtherUsersDataModel);
      // act
      final result = (await otherUserProfileRepositoryImpl
              .getOtherUsersProfiles(tOtherUserProfileDataSourceParams))
          .fold((l) => null, (r) => r);
      // assert
      expect(result, isA<OtherUserDataEntity>());
      verify(() => mockOtherUserRemoteDataSource
          .getOtherUsersProfiles(tOtherUserProfileDataSourceParams));
    });
    test(
        'getOtherUsersProfiles should return Server failure on left when error occurs',
        () async {
      // arrange
      when(() => mockOtherUserRemoteDataSource.getOtherUsersProfiles(
          tOtherUserProfileDataSourceParams)).thenThrow(tServerException);
      // act
      final result = (await otherUserProfileRepositoryImpl
              .getOtherUsersProfiles(tOtherUserProfileDataSourceParams))
          .fold((l) => l, (r) => null);
      // assert
      expect(result, isA<ServerFailure>());
      verify(() => mockOtherUserRemoteDataSource
          .getOtherUsersProfiles(tOtherUserProfileDataSourceParams));
    });

    test(
        'getUserFollowers should return other user followers following entity on right when success',
        () async {
      // arrange
      when(() => mockOtherUserRemoteDataSource
              .getUserFollowers(tOtherUserFollowersFollowingParams))
          .thenAnswer((_) async => tOtherUserFollowersFollowingDataModel);
      // act
      final result = (await otherUserProfileRepositoryImpl
              .getUserFollowers(tOtherUserFollowersFollowingParams))
          .fold((l) => null, (r) => r);
      // assert
      expect(result, isA<OtherUserFollowersFollowingDataEntity>());
      verify(() => mockOtherUserRemoteDataSource
          .getUserFollowers(tOtherUserFollowersFollowingParams));
    });
    test(
        'getOtherUserFollowrs should return Server failure on left when error occurs',
        () async {
      // arrange
      when(() => mockOtherUserRemoteDataSource.getUserFollowers(
          tOtherUserFollowersFollowingParams)).thenThrow(tServerException);
      // act
      final result = (await otherUserProfileRepositoryImpl
              .getUserFollowers(tOtherUserFollowersFollowingParams))
          .fold((l) => l, (r) => null);
      // assert
      expect(result, isA<ServerFailure>());
      verify(() => mockOtherUserRemoteDataSource
          .getUserFollowers(tOtherUserFollowersFollowingParams));
    });

    test(
        'getUserFollowing should return other user followers following entity on right when success',
        () async {
      // arrange
      when(() => mockOtherUserRemoteDataSource
              .getUserFollowing(tOtherUserFollowersFollowingParams))
          .thenAnswer((_) async => tOtherUserFollowersFollowingDataModel);
      // act
      final result = (await otherUserProfileRepositoryImpl
              .getUserFollowing(tOtherUserFollowersFollowingParams))
          .fold((l) => null, (r) => r);
      // assert
      expect(result, isA<OtherUserFollowersFollowingDataEntity>());
      verify(() => mockOtherUserRemoteDataSource
          .getUserFollowing(tOtherUserFollowersFollowingParams));
    });
    test(
        'getOtherUserFollowing should return Server failure on left when error occurs',
        () async {
      // arrange
      when(() => mockOtherUserRemoteDataSource.getUserFollowing(
          tOtherUserFollowersFollowingParams)).thenThrow(tServerException);
      // act
      final result = (await otherUserProfileRepositoryImpl
              .getUserFollowing(tOtherUserFollowersFollowingParams))
          .fold((l) => l, (r) => null);
      // assert
      expect(result, isA<ServerFailure>());
      verify(() => mockOtherUserRemoteDataSource
          .getUserFollowing(tOtherUserFollowersFollowingParams));
    });

    test(
        'getUserFollowing should return Other User Podcast entity on right when success',
        () async {
      // arrange
      when(() => mockOtherUserRemoteDataSource
              .getOtherUserPodcasts(tOtherUserPodcastParams))
          .thenAnswer((_) async => tOtherUserPodcastModel);
      // act
      final result = (await otherUserProfileRepositoryImpl
              .getOtherUserPodcast(tOtherUserPodcastParams))
          .fold((l) => null, (r) => r);
      // assert
      expect(result, isA<OtherUserPodcastEntity>());
      verify(() => mockOtherUserRemoteDataSource
          .getOtherUserPodcasts(tOtherUserPodcastParams));
    });
    test(
        'getOtherUserPodcast should return Server failure on left when error occurs',
        () async {
      // arrange
      when(() => mockOtherUserRemoteDataSource.getOtherUserPodcasts(
          tOtherUserPodcastParams)).thenThrow(tServerException);
      // act
      final result = (await otherUserProfileRepositoryImpl
              .getOtherUserPodcast(tOtherUserPodcastParams))
          .fold((l) => l, (r) => null);
      // assert
      expect(result, isA<ServerFailure>());
      verify(() => mockOtherUserRemoteDataSource
          .getOtherUserPodcasts(tOtherUserPodcastParams));
    });

    test(
        'getUserEvents should return Other User Events entity on right when success',
        () async {
      // arrange
      when(() => mockOtherUserRemoteDataSource
              .getOtherUserEvents(tOtherUserEventsParams))
          .thenAnswer((_) async => tOtherUserEventsModel);
      // act
      final result = (await otherUserProfileRepositoryImpl
              .getOtherUserEvents(tOtherUserEventsParams))
          .fold((l) => null, (r) => r);
      // assert
      expect(result, isA<OtherUserEventsEntity>());
      verify(() => mockOtherUserRemoteDataSource
          .getOtherUserEvents(tOtherUserEventsParams));
    });
    test('getUserEvents should return Server failure on left when error occurs',
        () async {
      // arrange
      when(() => mockOtherUserRemoteDataSource.getOtherUserEvents(
          tOtherUserEventsParams)).thenThrow(tServerException);
      // act
      final result = (await otherUserProfileRepositoryImpl
              .getOtherUserEvents(tOtherUserEventsParams))
          .fold((l) => l, (r) => null);
      // assert
      expect(result, isA<ServerFailure>());
      verify(() => mockOtherUserRemoteDataSource
          .getOtherUserEvents(tOtherUserEventsParams));
    });

    test('follow user should return Server failure on left when error occurs',
        () async {
      // arrange
      when(() => mockOtherUserRemoteDataSource
          .followUser(tFollowUnfollowUserParams)).thenThrow(tServerException);
      // act
      final result = (await otherUserProfileRepositoryImpl
              .followUser(tFollowUnfollowUserParams))
          .fold((l) => l, (r) => null);
      // assert
      expect(result, isA<ServerFailure>());
      verify(() =>
          mockOtherUserRemoteDataSource.followUser(tFollowUnfollowUserParams));
    });

    test(
        'un follow user should return Server failure on left when error occurs',
        () async {
      // arrange
      when(() => mockOtherUserRemoteDataSource
          .unFollowUser(tFollowUnfollowUserParams)).thenThrow(tServerException);
      // act
      final result = (await otherUserProfileRepositoryImpl
              .unFollowUser(tFollowUnfollowUserParams))
          .fold((l) => l, (r) => null);
      // assert
      expect(result, isA<ServerFailure>());
      verify(() => mockOtherUserRemoteDataSource
          .unFollowUser(tFollowUnfollowUserParams));
    });
  });
}
