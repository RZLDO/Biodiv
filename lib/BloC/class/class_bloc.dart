import 'dart:io';

import 'package:biodiv/repository/class_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
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
  }

  final ClassRepository repository;
  Future<void> getDetailClassData(
      GetDetailClass event, Emitter<ClassState> emit) async {
    final response = await repository.getDetailClass(event.idClass.toString());
    print(response.message);
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
}
