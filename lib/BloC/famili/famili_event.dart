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
