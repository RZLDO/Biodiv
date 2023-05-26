part of 'scarcity_bloc.dart';

abstract class ScarcityState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ScarcityLoading extends ScarcityState {}

class ScarcityFailure extends ScarcityState {
  final String ErrorMessage;
  ScarcityFailure({required this.ErrorMessage});

  @override
  List<Object?> get props => [];
}

class ScarcitySuccess extends ScarcityState {
  final GetScarcityModel result;
  ScarcitySuccess({required this.result});
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
