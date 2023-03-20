import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/signature_entity.dart';

class SignatureModel extends SignatureEntity {
  const SignatureModel(
      {required super.timestamp,
      required super.signature,
      required super.cloudName,
      required super.apiKey});

  factory SignatureModel.fromJson(Map<String, dynamic> json) {
    return SignatureModel(
      apiKey: json['apiKey'],
      cloudName: json['cloudName'],
      signature: json['signature'],
      timestamp: json['timestamp'],
    );
  }
}
