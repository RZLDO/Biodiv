part of 'ordo_bloc.dart';

abstract class OrdoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetOrdoData extends OrdoEvent {}

class GetDetailOrdoEvent extends OrdoEvent {
  final int idOrdo;
  GetDetailOrdoEvent({required this.idOrdo});

  @override
  List<Object?> get props => [idOrdo];
}

class AddOrdoEvent extends OrdoEvent {
  final int idClass;
  final String latinName;
  final String commonName;
  final String character;
  final String description;
  final XFile? image;

  AddOrdoEvent(
      {required this.idClass,
      required this.latinName,
      required this.commonName,
      required this.character,
      required this.description,
      required this.image});

  @override
  List<Object?> get props =>
      [idClass, latinName, commonName, character, description];
}

class DeleteOrdoEvent extends OrdoEvent {
  final int idOrdo;
  DeleteOrdoEvent({required this.idOrdo});

  @override
  List<Object?> get props => [idOrdo];
}
