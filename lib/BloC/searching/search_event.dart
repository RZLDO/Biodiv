part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetSearchEvent extends SearchEvent {
  final String query;

  GetSearchEvent({required this.query});

  @override
  List<Object?> get props => [query];
}
