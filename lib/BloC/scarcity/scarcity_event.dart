part of 'scarcity_bloc.dart';

abstract class ScarcityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetScarcityData extends ScarcityEvent {}

class GetScarcityId extends ScarcityEvent {}

class GetTotalScarcity extends ScarcityEvent {}

class GetScarcityById extends ScarcityEvent {
  final int idScarcity;

  GetScarcityById({required this.idScarcity});

  @override
  List<Object?> get props => [idScarcity];
}
