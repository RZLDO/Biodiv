import 'package:biodiv/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:biodiv/model/register_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'register_state.dart';
part 'register_event.dart';

class RegisterBlock extends Bloc<RegisterEvent, RegisterState> {
  @override
  RegisterBlock({required this.authRepository}) : super(RegisterInitial()) {
    on<RegisterButtonPressed>((event, emit) => register(event, emit));
  }
  final AuthRepository authRepository;

  Future register(
      RegisterButtonPressed event, Emitter<RegisterState> emit) async {
    final registerResponse = await authRepository.register(
        event.name, event.address, event.username, event.password);
    // ignore: unrelated_type_equality_checks
    if (registerResponse.error == true) {
      emit(RegisterFailure(errorMessage: registerResponse.message));
    } else {
      emit(RegisterSuccess(response: registerResponse));
    }
  }
}
