part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchResultStateSuccess extends SearchState {
  final SearchingModel result;

  SearchResultStateSuccess({required this.result});

  @override
  List<Object?> get props => [result];
}

class SearchResultStateFailure extends SearchState {
  final String failureMessage;

  SearchResultStateFailure({required this.failureMessage});

  @override
  List<Object?> get props => [failureMessage];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {
  final bool isLoading;

  SearchLoading({required this.isLoading});
  @override
  List<Object?> get props => [isLoading];
}
