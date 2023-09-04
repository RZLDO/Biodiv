part of 'news_bloc.dart';

class NewsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsSuccess extends NewsState {
  final GetNewsModel response;
  NewsSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

class NewsFailure extends NewsState {
  final String errorMessage;

  NewsFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class NewsDeleteState extends NewsState {
  final bool result;
  NewsDeleteState({required this.result});
  @override
  List<Object?> get props => [result];
}

class NewsAddState extends NewsState {
  final bool result;
  NewsAddState({required this.result});
  @override
  List<Object?> get props => [result];
}
