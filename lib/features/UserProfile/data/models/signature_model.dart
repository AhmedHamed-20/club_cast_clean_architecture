import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/signature_entitie.dart';

class SignatureModel extends SignatureEntitie {
  const SignatureModel(
      {required super.timestamp,
      required super.signature,
      required super.cloudName,
      required super.apiKey});

  factory SignatureModel.fromJson(Map<String, dynamic> json) {
    return SignatureModel(
      apiKey: json['apoKey'],
      cloudName: json['cloudName'],
      signature: json['signature'],
      timestamp: json['timestamp'],
    );
  }
}
