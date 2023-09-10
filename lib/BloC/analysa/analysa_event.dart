part of 'analysa_bloc.dart';

abstract class AnalysaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAnalysaEvent extends AnalysaEvent {
  final int idSpesies;

  GetAnalysaEvent({required this.idSpesies});
  @override
  List<Object?> get props => [idSpesies];
}
