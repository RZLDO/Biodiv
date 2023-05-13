import 'package:biodiv/repository/class_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:biodiv/model/get_class_model.dart';

part 'class_event.dart';
part 'class_state.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  ClassBloc({required this.repository}) : super(ClassInitial()) {
    on<GetDataClassEvent>(getData);
  }

  final ClassRepository repository;

  Future<void> getData(
      GetDataClassEvent event, Emitter<ClassState> emit) async {
    print("Trigger");
    final response = await repository.getDataClass();
    if (response.error == true) {
      emit(Failure(errorMessage: response.message));
    } else {
      emit(GetDataSuccess(getDataClass: response));
    }
  }
}
