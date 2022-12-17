import 'package:equatable/equatable.dart';

class PodcastUploadEntitie extends Equatable {
  final String name;
  final String category;
  final String publicId;
  const PodcastUploadEntitie(this.name, this.category, this.publicId);

  @override
  List<Object?> get props => [
        name,
        category,
        publicId,
      ];
}
