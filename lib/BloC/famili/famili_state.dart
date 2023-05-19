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
