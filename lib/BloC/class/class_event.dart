part of 'class_bloc.dart';

abstract class ClassEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetDataClassEvent extends ClassEvent {}

class PostDataClass extends ClassEvent {
  final String latinName;
  final String commonName;
  final String characteristics;
  final String description;
  final XFile? image;

  PostDataClass(
      {required this.latinName,
      required this.commonName,
      required this.characteristics,
      required this.description,
      required this.image});

  @override
  List<Object?> get props =>
      [latinName, commonName, characteristics, description, image];
}

class GetDetailClass extends ClassEvent {
  final int idClass;
  GetDetailClass({required this.idClass});

  @override
  List<Object?> get props => [idClass];
}
