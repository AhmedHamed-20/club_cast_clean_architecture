import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/repositories/base_other_user_repository.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/usecases/un_follow_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../Auth/domain/usecase/use_case_dumy_data.dart';
import '../../data/datasources/remote_other_users_dumy_data.dart';

class MockOtherUserProfilesRepository extends Mock
    implements BaseOtherUserProfilesRepository {}

void main() {
  late MockOtherUserProfilesRepository mockOtherUserProfilesRepository;
  late OtherUserUnFollowUsecase otherUserUnFollowUsecase;
  setUp(() {
    mockOtherUserProfilesRepository = MockOtherUserProfilesRepository();
    otherUserUnFollowUsecase =
        OtherUserUnFollowUsecase(mockOtherUserProfilesRepository);
  });
  group('test other user un follow usecase', () {
    test(
        'un follow user usecae should return failure on Left when error occurs',
        () async {
      // arrange
      when(() => mockOtherUserProfilesRepository
              .unFollowUser(tFollowUnfollowUserParams))
          .thenAnswer((_) async => const Left(tServerFailure));
      // act
      final result = (await otherUserUnFollowUsecase(tFollowUnfollowUserParams))
          .fold((l) => l, (r) => null);
      // assert
      expect(result, isA<Failure>());
      verify(() => mockOtherUserProfilesRepository
          .unFollowUser(tFollowUnfollowUserParams)).called(1);
    });
  });
}
