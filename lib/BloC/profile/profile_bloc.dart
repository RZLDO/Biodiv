import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/profile model/profile.dart';
import '../../repository/profile_repository.dart';

part 'profile_state.dart';
part 'profile_event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.repository}) : super(ProfileInitial()) {
    on<GetProfileEvent>(getProfile);
    on<ChangeUsernameEvent>(changeUsername);
    on<ChangePasswordEvent>(changePassword);
  }
  final ProfileRepository repository;
  Future<void> getProfile(
      GetProfileEvent event, Emitter<ProfileState> emit) async {
    final result = await repository.getDataFamili(event.idUser);
    emit(ProfileLoading());
    if (result.error == true) {
      emit(GetProfileStateFailure(message: result.message));
    } else {
      emit(GetProfileStateSuccess(result: result));
    }
  }

  Future<void> changeUsername(
      ChangeUsernameEvent event, Emitter<ProfileState> emit) async {
    final result =
        await repository.changeUsernameRepository(event.idUser, event.username);

    emit(ProfileLoading());
    if (result.error == true) {
      emit(StateFailure(message: result.message));
    } else {
      emit(ChangePasswordAndUsernameSuccess(result: result));
    }
  }

  Future<void> changePassword(
      ChangePasswordEvent event, Emitter<ProfileState> emit) async {
    final result = await repository.changePasswordRepository(
        event.idUser, event.oldPassword, event.newPassword);

    emit(ProfileLoading());
    if (result.error == true) {
      emit(StateFailure(message: result.message));
    } else {
      emit(ChangePasswordAndUsernameSuccess(result: result));
    }
  }
}
