import 'package:biodiv/model/search%20model/search_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/search_repository.dart';

part 'search_state.dart';
part 'search_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required this.repository}) : super(SearchInitial()) {
    on<GetSearchEvent>(searching);
  }

  final SearchingRepository repository;

  Future searching(GetSearchEvent event, Emitter<SearchState> emit) async {
    final result = await repository.getSearchingData(event.query);

    if (result.error) {
      emit(SearchLoading(isLoading: false));
      emit(SearchResultStateFailure(failureMessage: result.message));
    } else {
      emit(SearchLoading(isLoading: false));
      emit(SearchResultStateSuccess(result: result));
    }
  }
}
