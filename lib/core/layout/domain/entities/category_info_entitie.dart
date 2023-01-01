import 'package:equatable/equatable.dart';

class CategoryInfoEtitie extends Equatable {
  final String name;
  final String id;

  const CategoryInfoEtitie({
    required this.name,
    required this.id,
  });

  @override
  List<Object?> get props => [name, id];
}
