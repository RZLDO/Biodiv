part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetProfileStateSuccess extends ProfileState {
  final ProfileResponse result;

  GetProfileStateSuccess({required this.result});

  @override
  List<Object?> get props => [result];
}

class GetProfileStateFailure extends ProfileState {
  final String message;

  GetProfileStateFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class ChangePasswordAndUsernameSuccess extends ProfileState {
  final ChangePasswordAndUsernameResponse result;
  ChangePasswordAndUsernameSuccess({required this.result});

  @override
  List<Object?> get props => [result];
}

class StateFailure extends ProfileState {
  final String message;

  StateFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}
