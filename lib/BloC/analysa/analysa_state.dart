part of 'analysa_bloc.dart';

abstract class AnalysaState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AnalysaInitial extends AnalysaState {}

class AnalysaLoading extends AnalysaState {}

class GetAnalysaStateSuccess extends AnalysaState {
  Map<String, List<AnalysisData>> result;
  GetAnalysaStateSuccess({required this.result});
  @override
  List<Object?> get props => [result];
}

class GetAnalysaStateFailure extends AnalysaState {
  final String message;

  GetAnalysaStateFailure({required this.message});
  @override
  List<Object?> get props => [message];
}
