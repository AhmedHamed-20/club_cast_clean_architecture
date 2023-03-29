import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/other_users_data_entity.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/repositories/base_other_user_repository.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/usecases/get_user_profile_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../Auth/domain/usecase/use_case_dumy_data.dart';
import '../../data/datasources/remote_other_users_dumy_data.dart';

class MockOtherUsersProfilesRepository extends Mock
    implements BaseOtherUserProfilesRepository {}

void main() {
  late MockOtherUsersProfilesRepository mockOtherUsersProfilesRepository;
  late OtherUserProfileDataGetUsecase otherUserProfileDataGetUsecase;
  setUp(() {
    mockOtherUsersProfilesRepository = MockOtherUsersProfilesRepository();
    otherUserProfileDataGetUsecase =
        OtherUserProfileDataGetUsecase(mockOtherUsersProfilesRepository);
  });
  group('test otherUserProfileDataGetUsecase', () {
    test(
        'otherUserProfileDataGetUsecase should return OtherUserFollowersFollowingDataEntity on right when success',
        () async {
      // arrange
      const OtherUserDataEntity tOtherUserDataEntity = tOtherUsersDataModel;

      when(() => mockOtherUsersProfilesRepository
              .getOtherUsersProfiles(tOtherUserProfileDataSourceParams))
          .thenAnswer((_) async => const Right(tOtherUserDataEntity));
      // act
      final result = await otherUserProfileDataGetUsecase(
          tOtherUserProfileDataSourceParams);
      // assert
      expect(result, const Right(tOtherUserDataEntity));
      verify(() => mockOtherUsersProfilesRepository
          .getOtherUsersProfiles(tOtherUserProfileDataSourceParams)).called(1);
    });
    test(
        'otherUserProfileDataGetUsecase should return failure on left when error occurs',
        () async {
      // arrange

      when(() => mockOtherUsersProfilesRepository
              .getOtherUsersProfiles(tOtherUserProfileDataSourceParams))
          .thenAnswer((_) async => const Left(tServerFailure));
      // act
      final result = (await otherUserProfileDataGetUsecase(
              tOtherUserProfileDataSourceParams))
          .fold((l) => l, (r) => null); // assert
      expect(result, isA<Failure>());
      verify(() => mockOtherUsersProfilesRepository
          .getOtherUsersProfiles(tOtherUserProfileDataSourceParams)).called(1);
    });
  });
}
