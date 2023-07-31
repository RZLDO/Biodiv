part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetProfileEvent extends ProfileEvent {
  final int idUser;
  GetProfileEvent({required this.idUser});
  @override
  List<Object?> get props => [idUser];
}

class ChangePasswordEvent extends ProfileEvent {
  final int idUser;
  final String oldPassword;
  final String newPassword;
  ChangePasswordEvent(
      {required this.idUser,
      required this.oldPassword,
      required this.newPassword});
  @override
  List<Object?> get props => [idUser];
}

class ChangeUsernameEvent extends ProfileEvent {
  final int idUser;
  final String username;
  ChangeUsernameEvent({required this.idUser, required this.username});
  @override
  List<Object?> get props => [idUser];
}
