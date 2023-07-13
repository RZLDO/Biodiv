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
