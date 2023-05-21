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
