import 'package:biodiv/repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:biodiv/model/login_model.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) => loginEventToState(event, emit));
  }
  final AuthRepository authRepository;

  Future loginEventToState(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    final loginResponse =
        await authRepository.login(event.username, event.password);
    print(loginResponse.message);
    if (loginResponse.error == true) {
      emit(LoginFailure(errorMessage: loginResponse.message));
    } else {
      emit(LoginSuccess(response: loginResponse));
    }
  }
}
