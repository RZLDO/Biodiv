part of 'verif_bloc.dart';

abstract class VerifEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUnverifiedData extends VerifEvent {}

class GetUnverifClass extends VerifEvent {}

class GetUnverifGenus extends VerifEvent {}

class GetUnverifOrdo extends VerifEvent {}

class GetUnverifFamili extends VerifEvent {}

class VerifClassEvent extends VerifEvent {
  final int id;
  final String path;
  VerifClassEvent({required this.id, required this.path});

  @override
  List<Object?> get props => [];
}

class DeleteUnverifEvent extends VerifEvent {
  final int id;
  final String path;

  DeleteUnverifEvent({required this.id, required this.path});

  @override
  List<Object?> get props => [id, path];
}
