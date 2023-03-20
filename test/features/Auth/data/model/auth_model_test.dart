import 'package:club_cast_clean_architecture/features/Auth/data/models/auth_model.dart';
import 'package:flutter_test/flutter_test.dart';

final tAuthModelJson = {
  'token': 'accessToken',
};
void main() {
  group('test auth model', () {
    late AuthModel authModel;
    setUp(() {
      authModel = const AuthModel('accessToken');
    });
    test('test auth model from json', () {
      final result = AuthModel.fromJson(tAuthModelJson);
      expect(result, authModel);
      expect(authModel.token, isA<String>());
    });
  });
}
