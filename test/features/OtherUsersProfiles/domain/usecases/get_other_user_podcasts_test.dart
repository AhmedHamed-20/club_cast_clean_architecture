import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/other_user_podcast_entity.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/repositories/base_other_user_repository.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/usecases/get_other_user_podcasts.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../Auth/domain/usecase/use_case_dumy_data.dart';
import '../../data/datasources/remote_other_users_dumy_data.dart';

class MockOtherUserProfilesRepository extends Mock
    implements BaseOtherUserProfilesRepository {}

void main() {
  late MockOtherUserProfilesRepository mockOtherUserProfilesRepository;
  late OtherUserPodcastUsecase otherUserPodcastUsecase;
  setUp(() {
    mockOtherUserProfilesRepository = MockOtherUserProfilesRepository();
    otherUserPodcastUsecase =
        OtherUserPodcastUsecase(mockOtherUserProfilesRepository);
  });
  group('test other podcast get usecase', () {
    test(
        'other user podcast usecase should return other user podcast entity on right',
        () async {
      // arrange
      const OtherUserPodcastEntity tOtherUserPodcastEntity =
          tOtherUserPodcastModel;
      when(() => mockOtherUserProfilesRepository
              .getOtherUserPodcast(tOtherUserPodcastParams))
          .thenAnswer((_) async => const Right(tOtherUserPodcastEntity));
      // act
      final result = await otherUserPodcastUsecase(tOtherUserPodcastParams);
      // assert
      expect(result, const Right(tOtherUserPodcastEntity));
      verify(() => mockOtherUserProfilesRepository
          .getOtherUserPodcast(tOtherUserPodcastParams)).called(1);
    });
    test('other user podcast usecase should return failure on left', () async {
      // arrange

      when(() => mockOtherUserProfilesRepository
              .getOtherUserPodcast(tOtherUserPodcastParams))
          .thenAnswer((_) async => const Left(tServerFailure));
      // act
      final result = (await otherUserPodcastUsecase(tOtherUserPodcastParams))
          .fold((l) => l, (r) => null);
      // assert
      expect(result, isA<Failure>());
      verify(() => mockOtherUserProfilesRepository
          .getOtherUserPodcast(tOtherUserPodcastParams)).called(1);
    });
  });
}
