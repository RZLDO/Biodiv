part of 'spesies_bloc.dart';

abstract class SpesiesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetSpesiesData extends SpesiesEvent {}

class GetDetailSpecies extends SpesiesEvent {
  final int idSpesies;
  GetDetailSpecies({required this.idSpesies});

  @override
  List<Object?> get props => [idSpesies];
}

class GetSpesiesByScarcity extends SpesiesEvent {
  final int idScarcity;
  GetSpesiesByScarcity({required this.idScarcity});

  @override
  List<Object?> get props => [idScarcity];
}

class GetSpesiesByGenus extends SpesiesEvent {
  final int idGenus;
  final int page;

  GetSpesiesByGenus({required this.idGenus, required this.page});

  @override
  List<Object?> get props => [idGenus, page];
}

class DeleteSpesiesEvent extends SpesiesEvent {
  final int idSpesies;
  DeleteSpesiesEvent({required this.idSpesies});

  @override
  List<Object?> get props => [idSpesies];
}

class AddSpesiesDataEvent extends SpesiesEvent {
  final int idGenus;
  final int idCategory;
  final String latinName;
  final String commonName;
  final String habitat;
  final String status;
  final String character;
  final String description;
  final XFile? image;

  AddSpesiesDataEvent(
      {required this.idGenus,
      required this.idCategory,
      required this.latinName,
      required this.commonName,
      required this.habitat,
      required this.status,
      required this.character,
      required this.description,
      required this.image});

  @override
  List<Object?> get props => [
        idGenus,
        idCategory,
        latinName,
        commonName,
        habitat,
        status,
        character,
        description,
        image
      ];
}

class UpdateSpesiesDataEvent extends SpesiesEvent {
  final int idGenus;
  final int idCategory;
  final String latinName;
  final String commonName;
  final String habitat;
  final String status;
  final String character;
  final String description;
  final XFile? image;
  final int idSpesies;

  UpdateSpesiesDataEvent(
      {required this.idGenus,
      required this.idCategory,
      required this.latinName,
      required this.commonName,
      required this.habitat,
      required this.status,
      required this.character,
      required this.description,
      required this.image,
      required this.idSpesies});

  @override
  List<Object?> get props => [
        idGenus,
        idCategory,
        latinName,
        commonName,
        habitat,
        status,
        character,
        description,
        image,
        idSpesies
      ];
}

class AddLocationSpesiesEvent extends SpesiesEvent {
  final String locationName;
  final double latitude;
  final double longitude;
  final int radius;
  final int idSpesies;

  AddLocationSpesiesEvent(
      {required this.locationName,
      required this.latitude,
      required this.longitude,
      required this.radius,
      required this.idSpesies});

  @override
  List<Object?> get props =>
      [locationName, latitude, longitude, radius, idSpesies];
}
