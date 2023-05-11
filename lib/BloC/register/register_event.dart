part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterButtonPressed extends RegisterEvent {
  final String name;
  final String address;
  final String username;
  final String password;

  RegisterButtonPressed(
      {required this.name,
      required this.address,
      required this.username,
      required this.password});

  @override
  List<Object?> get props => [name, address, username, password];
}
