part of 'ordo_bloc.dart';

abstract class OrdoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrdoInitial extends OrdoState {}

class OrdoLoading extends OrdoState {}

class GetOrdoByClassState extends OrdoState {
  final OrdoResponse result;
  GetOrdoByClassState({required this.result});

  @override
  List<Object?> get props => [result];
}

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

class UpdateOrdoStateSuccess extends OrdoState {
  final UpdateOrdoModel response;
  UpdateOrdoStateSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

class GetIdLatinOrdoSuccess extends OrdoState {
  final List<int> idOrdo;
  final List<String> latinName;

  GetIdLatinOrdoSuccess({required this.idOrdo, required this.latinName});

  @override
  List<Object?> get props => [idOrdo, latinName];
}
