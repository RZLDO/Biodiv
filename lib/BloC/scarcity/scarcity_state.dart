part of 'scarcity_bloc.dart';

abstract class ScarcityState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ScarcityLoading extends ScarcityState {}

class ScarcityFailure extends ScarcityState {
  final String errorMessage;
  ScarcityFailure({required this.errorMessage});

  @override
  List<Object?> get props => [];
}

class ScarcitySuccess extends ScarcityState {
  final GetScarcityModel data;
  final List<ScarcityModelChart> result;
  ScarcitySuccess({required this.data, required this.result});
  @override
  List<Object?> get props => [result];
}

class GetIdScarcity extends ScarcityState {
  final List<int> idScarcity;
  final List<String> nameScarcity;

  GetIdScarcity({required this.idScarcity, required this.nameScarcity});

  @override
  List<Object?> get props => [idScarcity, nameScarcity];
}

class GetDetailScarcityByIdState extends ScarcityState {
  final DetailScarcity result;
  GetDetailScarcityByIdState({required this.result});

  @override
  List<Object?> get props => [result];
}

class GetTotalScarcitySuccess extends ScarcityState {
  final List<ScarcityModelChart> result;

  GetTotalScarcitySuccess({required this.result});

  @override
  List<Object?> get props => [result];
}
