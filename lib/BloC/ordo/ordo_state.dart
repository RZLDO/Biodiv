part of 'ordo_bloc.dart';

abstract class OrdoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrdoInitial extends OrdoState {}

class OrdoLoading extends OrdoState {}

class Success extends OrdoState {
  final OrdoResponse response;
  Success({required this.response});

  @override
  List<Object?> get props => [response];
}

class Failure extends OrdoState {
  final String errorMessage;
  Failure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
