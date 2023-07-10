part of 'famili_bloc.dart';

abstract class FamiliEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetFamiliEvent extends FamiliEvent {}

class GetFamiliByOrdo extends FamiliEvent {
  final int idOrdo;
  final int page;
  GetFamiliByOrdo({required this.idOrdo, required this.page});

  @override
  List<Object?> get props => [idOrdo];
}

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

class GetIdLatinFamiliEvent extends FamiliEvent {}

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

class UpdateDatafamiliEvent extends FamiliEvent {
  final int idFamili;
  final int idOrdo;
  final String latinName;
  final String commonName;
  final String character;
  final String description;
  final XFile? image;

  UpdateDatafamiliEvent({
    required this.idFamili,
    required this.idOrdo,
    required this.latinName,
    required this.commonName,
    required this.character,
    required this.description,
    required this.image,
  });
  @override
  List<Object?> get props =>
      [idFamili, idOrdo, latinName, commonName, character, description, image];
}
