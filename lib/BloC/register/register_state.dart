part of 'register_bloc.dart';

class RegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final RegisterResponse response;

  RegisterSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

class RegisterFailure extends RegisterState {
  final String errorMessage;

  RegisterFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
