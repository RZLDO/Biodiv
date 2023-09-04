part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetNewsDataEvent extends NewsEvent {}

class AddNewsEvent extends NewsEvent {
  final String judul;
  final String deskripsi;
  final String webUrl;
  final XFile? image;

  AddNewsEvent(
      {required this.judul,
      required this.deskripsi,
      required this.webUrl,
      required this.image});

  @override
  List<Object?> get props => [judul, deskripsi, webUrl, image];
}

class DeleteNewsEvent extends NewsEvent {
  final int idBerita;

  DeleteNewsEvent({required this.idBerita});

  @override
  List<Object?> get props => [idBerita];
}
