part of 'famili_bloc.dart';

abstract class FamiliEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetFamiliEvent extends FamiliEvent {}

class GetFamiliDetailevent extends FamiliEvent {
  final int idFamili;
  GetFamiliDetailevent({required this.idFamili});

  @override
  List<Object?> get props => [idFamili];
}

class DeleteFamiliEvent extends FamiliEvent {
  final int idFamili;

  DeleteFamiliEvent({required this.idFamili});

  @override
  List<Object?> get props => [idFamili];
}

class GetIdLatinEvent extends FamiliEvent {}

class AddDatafamiliEvent extends FamiliEvent {
  final int idOrdo;
  final String latinName;
  final String commonName;
  final String character;
  final String description;
  final XFile? image;

  AddDatafamiliEvent({
    required this.idOrdo,
    required this.latinName,
    required this.commonName,
    required this.character,
    required this.description,
    required this.image,
  });
  @override
  List<Object?> get props =>
      [idOrdo, latinName, commonName, character, description, image];
}
