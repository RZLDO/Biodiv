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

class FailureOrdo extends OrdoState {
  final String errorMessage;
  FailureOrdo({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class DetailStateSuccess extends OrdoState {
  final DetailOrdoModel response;
  DetailStateSuccess({required this.response});
  @override
  List<Object?> get props => [response];
}

class AddOrdoSuccess extends OrdoState {
  final AddOrdoData response;
  AddOrdoSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

class DeleteOrdoStateSuccess extends OrdoState {
  final DeleteOrdoModel response;
  DeleteOrdoStateSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}
