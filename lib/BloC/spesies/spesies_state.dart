part of 'spesies_bloc.dart';

abstract class SpesiesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SpesiesLoading extends SpesiesState {}

class SpesiesFailure extends SpesiesState {
  final String errorMessage;

  SpesiesFailure({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class GetSpesiciesSuccess extends SpesiesState {
  final SpesiesGetAllModel result;
  GetSpesiciesSuccess({required this.result});

  @override
  List<Object?> get props => [result];
}

class AddDataSuccess extends SpesiesState {
  final AddData result;
  AddDataSuccess({required this.result});
  @override
  List<Object?> get props => [result];
}

class UpdateDataSuccess extends SpesiesState {
  final AddData result;
  UpdateDataSuccess({required this.result});
  @override
  List<Object?> get props => [result];
}
