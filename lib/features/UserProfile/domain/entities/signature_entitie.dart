import 'package:equatable/equatable.dart';

class SignatureEntitie extends Equatable {
  final int timestamp;
  final String signature;
  final String cloudName;
  final String apiKey;

  const SignatureEntitie(
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
