import 'package:biodiv/model/Class%20Model/update_data_class.dart';
import 'package:biodiv/repository/class_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/Class Model/detail_class_model.dart';
import '../../model/Class Model/get_class_model.dart';

part 'class_event.dart';
part 'class_state.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  ClassBloc({required this.repository}) : super(ClassInitial()) {
    on<GetDataClassEvent>(getData);
    on<PostDataClass>(postData);
    on<GetDetailClass>(getDetailClassData);
    on<DeleteClass>(deleteClassData);
    on<EditClass>(editData);
    on<GetIdClass>(getIdClass);
  }

  final ClassRepository repository;

  Future<void> getIdClass(GetIdClass event, Emitter<ClassState> emit) async {
    final response = await repository.getDataClass();

    if (response.error == false) {
      List<ClassData> data = response.data;
      List<String> latinName = [];
      List<int> idClass = [];
      for (var item in data) {
        latinName.add(item.namaLatin);
        idClass.add(item.idClass);
      }

      emit(GetIdClassSucces(idClass: idClass, latinName: latinName));
    } else {
      emit(Failure(errorMessage: response.message));
    }
  }

  Future<void> editData(EditClass event, Emitter<ClassState> emit) async {
    final result = await repository.editClassData(
        event.idClass,
        event.latinName,
        event.commonName,
        event.characteristics,
        event.description,
        event.image);
    if (result.error == true) {
      emit(Failure(errorMessage: result.message));
    } else {
      emit(EditSuccess(response: result));
    }
  }

  Future<void> getDetailClassData(
      GetDetailClass event, Emitter<ClassState> emit) async {
    final response = await repository.getDetailClass(event.idClass.toString());
    if (response.error == true) {
      emit(Failure(errorMessage: response.message));
    } else {
      emit(DetailSuccess(detail: response));
    }
  }

  Future<void> postData(PostDataClass event, Emitter<ClassState> emit) async {
    final response = await repository.addClassData(
        event.latinName,
        event.commonName,
        event.characteristics,
        event.description,
        event.image);
    if (response.error == true) {
      emit(Failure(errorMessage: response.message));
    } else {
      emit(AddDataSuccess(postDataClass: response));
    }
  }

  Future<void> getData(
      GetDataClassEvent event, Emitter<ClassState> emit) async {
    final response = await repository.getDataClass();
    if (response.error == true) {
      emit(Failure(errorMessage: response.message));
    } else {
      emit(GetDataSuccess(dataClass: response.data));
    }
  }

  Future<void> deleteClassData(
      DeleteClass event, Emitter<ClassState> emit) async {
    final result = await repository.deleteClassRepository(event.idClass);
    emit(DeleteSuccess(response: result));
  }
}
