import 'package:equatable/equatable.dart';

class SignatureEntity extends Equatable {
  final int timestamp;
  final String signature;
  final String cloudName;
  final String apiKey;

  const SignatureEntity(
      {required this.timestamp,
      required this.signature,
      required this.cloudName,
      required this.apiKey});

  @override
  List<Object?> get props => [
        timestamp,
        signature,
        cloudName,
        apiKey,
      ];
}
