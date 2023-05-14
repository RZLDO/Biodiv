part of 'ordo_bloc.dart';

abstract class OrdoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetOrdoData extends OrdoEvent {}
