import 'package:biodiv/model/News%20Model/news_model.dart';
import 'package:biodiv/repository/news_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'news_state.dart';
part 'news_event.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc({required this.newsRepository}) : super(NewsInitial()) {
    on<GetNewsDataEvent>((event, emit) => getNewsEventToState(event, emit));
    on<DeleteNewsEvent>((event, emit) => deleteNews(event, emit));
    on<AddNewsEvent>((event, emit) => addNews(event, emit));
  }
  final NewsRepository newsRepository;

  Future addNews(AddNewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());

    final result = await newsRepository.addNews(
        event.judul, event.deskripsi, event.webUrl, event.image);
    emit(NewsAddState(result: result.error));
  }

  Future deleteNews(DeleteNewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    final result = await newsRepository.deleteNews(event.idBerita);
    emit(NewsDeleteState(result: result.error));
  }

  Future getNewsEventToState(
      GetNewsDataEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    final result = await newsRepository.getNews();
    if (result.error == true) {
      emit(NewsFailure(errorMessage: result.message));
    } else {
      emit(NewsSuccess(response: result));
    }
  }
}
