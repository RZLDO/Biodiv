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
