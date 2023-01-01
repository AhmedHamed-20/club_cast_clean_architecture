import 'package:equatable/equatable.dart';

class PodcastUploadEntitie extends Equatable {
  final String name;
  final String publicId;
  const PodcastUploadEntitie(this.name, this.publicId);

  @override
  List<Object?> get props => [
        name,
        publicId,
      ];
}
