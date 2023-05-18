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
