import 'dart:io';

import 'package:biodiv/repository/class_repository.dart';
import 'package:biodiv/ui/class%20page/add_data_class.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:biodiv/model/get_class_model.dart';
import 'package:image_picker/image_picker.dart';

part 'class_event.dart';
part 'class_state.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  ClassBloc({required this.repository}) : super(ClassInitial()) {
    on<GetDataClassEvent>(getData);
    on<PostDataClass>(postData);
  }

  final ClassRepository repository;
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
