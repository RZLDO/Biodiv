part of 'verif_bloc.dart';

abstract class VerifState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VerifLoadingState extends VerifState {}

class VerifFailure extends VerifState {
  final String errorMessage;
  VerifFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class GetUnverifiedDataSuccess extends VerifState {
  final List<int?> data;
  GetUnverifiedDataSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class GetUnverifiedClassSuccess extends VerifState {
  final GetDataClass result;
  GetUnverifiedClassSuccess({required this.result});

  @override
  List<Object> get props => [result];
}

class GetUnverifiedGenusSuccess extends VerifState {
  final GetGenusModel result;
  GetUnverifiedGenusSuccess({required this.result});

  @override
  List<Object?> get props => [result];
}

class GetUnverifiedOrdoSuccess extends VerifState {
  final OrdoResponse result;

  GetUnverifiedOrdoSuccess({required this.result});

  @override
  List<Object?> get props => [result];
}

class GetUnverifiedFamili extends VerifState {
  final FamiliResponseModel result;

  GetUnverifiedFamili({required this.result});

  @override
  List<Object?> get props => [result];
}
