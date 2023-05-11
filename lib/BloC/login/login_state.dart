part of 'login_bloc.dart';

class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginResponse response;

  LoginSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

class LoginFailure extends LoginState {
  final String errorMessage;

  LoginFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
