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
