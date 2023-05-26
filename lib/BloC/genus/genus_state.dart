part of 'genus_bloc.dart';

abstract class GenusState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GenusLoading extends GenusState {}

class GetGenusDataSuccess extends GenusState {
  final GetGenusModel result;

  GetGenusDataSuccess({required this.result});

  @override
  List<Object?> get props => [];
}

class GenusFailure extends GenusState {
  final String errorMessage;

  GenusFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class GetGenusDetailDataSuccess extends GenusState {
  final GetDetailGenusModel result;

  GetGenusDetailDataSuccess({required this.result});

  @override
  List<Object?> get props => [];
}

class DeleteGenusSuccess extends GenusState {
  final DeleteGenusModel result;
  DeleteGenusSuccess({required this.result});

  @override
  List<Object?> get props => [result];
}

class GetGenusIdLatinSuccess extends GenusState {
  final List<int> idOrdo;
  final List<String> latinName;

  GetGenusIdLatinSuccess({required this.idOrdo, required this.latinName});

  @override
  List<Object?> get props => [idOrdo, latinName];
}

class AddDataGenusSuccess extends GenusState {
  final AddDataGenusModel result;
  AddDataGenusSuccess({required this.result});
  @override
  List<Object?> get props => [result];
}

class UpdateGenusSuccess extends GenusState {
  final AddDataGenusModel result;
  UpdateGenusSuccess({required this.result});
  @override
  List<Object?> get props => [result];
}

class GetIdLatinGenusSuccess extends GenusState {
  final List<int> idGenus;
  final List<String> latinName;

  GetIdLatinGenusSuccess({required this.idGenus, required this.latinName});
  @override
  List<Object?> get props => [idGenus, latinName];
}
