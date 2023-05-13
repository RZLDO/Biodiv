import 'package:biodiv/repository/class_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'class_event.dart';
part 'class_state.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  ClassBloc({required this.repository}) : super(ClassInitial()) {
    on<GetDataClassEvent>(getData);
  }

  final ClassRepository repository;

  Future<void> getData(
      GetDataClassEvent event, Emitter<ClassState> emit) async {
    final response = await repository.getDataClass();
    if (response.error == true) {
      emit(Failure(errorMessage: response.message));
    } else {
      emit(GetDataSuccess(getDataClass: response));
    }
  }
}
