import 'package:equatable/equatable.dart';

class PodcastUploadEntity extends Equatable {
  final String name;
  final String publicId;
  const PodcastUploadEntity(this.name, this.publicId);

  @override
  List<Object?> get props => [
        name,
        publicId,
      ];
}
