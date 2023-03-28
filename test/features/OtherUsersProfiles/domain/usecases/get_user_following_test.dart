import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/followers_following_data_entity.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/repositories/base_other_user_repository.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/usecases/get_user_following.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../Auth/domain/usecase/use_case_dumy_data.dart';
import '../../data/datasources/remote_other_users_dumy_data.dart';

class MockOtherUsersProfilesRepository extends Mock
    implements BaseOtherUserProfilesRepository {}

void main() {
  late MockOtherUsersProfilesRepository mockOtherUsersProfilesRepository;
  late OtherUserFollowingUsecase otherUserFollowingUsecase;
  setUp(() {
    mockOtherUsersProfilesRepository = MockOtherUsersProfilesRepository();
    otherUserFollowingUsecase =
        OtherUserFollowingUsecase(mockOtherUsersProfilesRepository);
  });
  group('test otherUserFollowingUsecase', () {
    test(
        'otherUserFollowingUsecase should return OtherUserFollowersFollowingDataEntity on right when success',
        () async {
      // arrange
      const OtherUserFollowersFollowingDataEntity
          tOtherUserFollowersFollowingDataEntity =
          tOtherUserFollowersFollowingDataModel;

      when(() => mockOtherUsersProfilesRepository
              .getUserFollowing(tOtherUserFollowersFollowingParams))
          .thenAnswer(
              (_) async => const Right(tOtherUserFollowersFollowingDataEntity));
      // act
      final result =
          await otherUserFollowingUsecase(tOtherUserFollowersFollowingParams);
      // assert
      expect(result, const Right(tOtherUserFollowersFollowingDataEntity));
      verify(() => mockOtherUsersProfilesRepository
          .getUserFollowing(tOtherUserFollowersFollowingParams)).called(1);
    });
    test(
        'otherUserFollowingUsecase should return failure on left when error occurs',
        () async {
      // arrange

      when(() => mockOtherUsersProfilesRepository
              .getUserFollowing(tOtherUserFollowersFollowingParams))
          .thenAnswer((_) async => const Left(tServerFailure));
      // act
      final result =
          (await otherUserFollowingUsecase(tOtherUserFollowersFollowingParams))
              .fold((l) => l, (r) => null); // assert
      expect(result, isA<Failure>());
      verify(() => mockOtherUsersProfilesRepository
          .getUserFollowing(tOtherUserFollowersFollowingParams)).called(1);
    });
  });
}
