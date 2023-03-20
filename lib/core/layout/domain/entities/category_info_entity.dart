import 'package:equatable/equatable.dart';

class CategoryInfoEntity extends Equatable {
  final String name;
  final String id;

  const CategoryInfoEntity({
    required this.name,
    required this.id,
  });

  @override
  List<Object?> get props => [name, id];
}
