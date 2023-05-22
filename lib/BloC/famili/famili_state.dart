part of 'famili_bloc.dart';

abstract class FamiliState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FamiliLoading extends FamiliState {}

class GetDataFamiliSuccess extends FamiliState {
  final FamiliResponseModel result;

  GetDataFamiliSuccess({required this.result});

  @override
  List<Object?> get props => [result];
}

class FailureFamili extends FamiliState {
  final String errorMessage;

  FailureFamili({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class GetDetailFamiliSuccess extends FamiliState {
  final FamiliDetailModel result;

  GetDetailFamiliSuccess({required this.result});
  @override
  List<Object?> get props => [result];
}

class DeleteFamiliSuccess extends FamiliState {
  final DeleteFamiliModel result;
  DeleteFamiliSuccess({required this.result});

  @override
  List<Object?> get props => [result];
}

class GetIdLatinSuccess extends FamiliState {
  final List<int> idFamili;
  final List<String> namaLatin;

  GetIdLatinSuccess({required this.idFamili, required this.namaLatin});

  @override
  List<Object?> get props => [idFamili, namaLatin];
}

class AddDataFamiliSuccess extends FamiliState {
  final AddFamiliModel result;
  AddDataFamiliSuccess({required this.result});

  @override
  List<Object?> get props => [result];
}

class UpdateFamiliSuccess extends FamiliState {
  final UpdateFamiliModel result;

  UpdateFamiliSuccess({required this.result});

  @override
  List<Object?> get props => [result];
}
