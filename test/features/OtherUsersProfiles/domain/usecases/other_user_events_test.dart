import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/other_user_event.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/repositories/base_other_user_repository.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/usecases/other_user_events.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../Auth/domain/usecase/use_case_dumy_data.dart';
import '../../data/datasources/remote_other_users_dumy_data.dart';

class MockOtherUsersProfilesRepository extends Mock
    implements BaseOtherUserProfilesRepository {}

void main() {
  late MockOtherUsersProfilesRepository mockOtherUsersProfilesRepository;
  late OtherUserEventsUsecase otherUserEventsUsecase;
  setUp(() {
    mockOtherUsersProfilesRepository = MockOtherUsersProfilesRepository();
    otherUserEventsUsecase =
        OtherUserEventsUsecase(mockOtherUsersProfilesRepository);
  });
  group('test otherUserEventsUsecase', () {
    test(
        'otherUserEventsUsecase should return other user events entity on right when success',
        () async {
      // arrange
      const OtherUserEventsEntity tOtherUserEventsEntity =
          tOtherUserEventsModel;

      when(() => mockOtherUsersProfilesRepository
              .getOtherUserEvents(tOtherUserEventsParams))
          .thenAnswer((_) async => const Right(tOtherUserEventsEntity));
      // act
      final result = await otherUserEventsUsecase(tOtherUserEventsParams);
      // assert
      expect(result, const Right(tOtherUserEventsEntity));
      verify(() => mockOtherUsersProfilesRepository
          .getOtherUserEvents(tOtherUserEventsParams)).called(1);
    });
    test(
        'otherUserEventsUsecase should return failure on left when error occurs',
        () async {
      // arrange

      when(() => mockOtherUsersProfilesRepository
              .getOtherUserEvents(tOtherUserEventsParams))
          .thenAnswer((_) async => const Left(tServerFailure));
      // act
      final result = (await otherUserEventsUsecase(tOtherUserEventsParams))
          .fold((l) => l, (r) => null); // assert
      expect(result, isA<Failure>());
      verify(() => mockOtherUsersProfilesRepository
          .getOtherUserEvents(tOtherUserEventsParams)).called(1);
    });
  });
}
