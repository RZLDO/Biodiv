part of 'genus_bloc.dart';

abstract class GenusEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetDataGenusEvent extends GenusEvent {}

class GetDetailGenusEvent extends GenusEvent {
  final int idGenus;
  GetDetailGenusEvent({required this.idGenus});

  @override
  List<Object?> get props => [idGenus];
}

class DeleteGenusEvent extends GenusEvent {
  final int idGenus;
  DeleteGenusEvent({required this.idGenus});

  @override
  List<Object?> get props => [idGenus];
}

class GetIdLatinGenusEvent extends GenusEvent {}

class AddDataGenusEvent extends GenusEvent {
  final int idFamili;
  final String latinName;
  final String commonName;
  final String characterteristics;
  final String description;
  final XFile? image;

  AddDataGenusEvent(
      {required this.idFamili,
      required this.latinName,
      required this.commonName,
      required this.characterteristics,
      required this.description,
      required this.image});
  @override
  List<Object?> get props =>
      [idFamili, latinName, commonName, characterteristics, description, image];
}

class UpdateDataGenusEvent extends GenusEvent {
  final int idGenus;
  final int idFamili;
  final String latinName;
  final String commonName;
  final String characterteristics;
  final String description;
  final XFile? image;

  UpdateDataGenusEvent(
      {required this.idFamili,
      required this.latinName,
      required this.commonName,
      required this.characterteristics,
      required this.description,
      required this.idGenus,
      required this.image});
  @override
  List<Object?> get props => [
        idFamili,
        latinName,
        commonName,
        characterteristics,
        description,
        idGenus,
        image
      ];
}
