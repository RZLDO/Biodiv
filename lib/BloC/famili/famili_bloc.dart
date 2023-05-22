import 'package:biodiv/model/famili%20model/add_famili_model.dart';
import 'package:biodiv/model/famili%20model/delete_famili.dart';
import 'package:biodiv/model/famili%20model/detai_famili_mode.dart';
import 'package:biodiv/model/famili%20model/famili_model.dart';
import 'package:biodiv/model/genus/get_data_genus.dart';
import 'package:biodiv/repository/famili_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/famili model/update_famili_model.dart';

part 'famili_state.dart';
part 'famili_event.dart';

class FamiliBloc extends Bloc<FamiliEvent, FamiliState> {
  FamiliBloc({required this.repository}) : super(FamiliLoading()) {
    on<GetFamiliEvent>(getDataFamili);
    on<GetFamiliDetailevent>(getDetailFamili);
    on<DeleteFamiliEvent>(deleteFamili);
    on<AddDatafamiliEvent>(addFamiliData);
    on<UpdateDatafamiliEvent>(updateFamiliData);
    on<GetIdLatinFamiliEvent>(getIdLatin);
  }
  final FamiliRepository repository;

  Future<void> getDataFamili(
      GetFamiliEvent event, Emitter<FamiliState> emit) async {
    final result = await repository.getFamiliData();
    if (result.error) {
      emit(FailureFamili(errorMessage: result.message));
    } else {
      emit(GetDataFamiliSuccess(result: result));
    }
  }

  Future<void> getDetailFamili(
      GetFamiliDetailevent event, Emitter<FamiliState> emit) async {
    final result = await repository.getDetailFamiliData(event.idFamili);
    if (result.error) {
      emit(FailureFamili(errorMessage: result.message));
    } else {
      emit(GetDetailFamiliSuccess(result: result));
    }
  }

  Future<void> deleteFamili(
      DeleteFamiliEvent event, Emitter<FamiliState> emit) async {
    final result = await repository.deletFamili(event.idFamili);
    if (result.error == true) {
      emit(FailureFamili(errorMessage: result.message));
    } else {
      emit(DeleteFamiliSuccess(result: result));
    }
  }

  Future<void> getIdLatin(
      GetIdLatinFamiliEvent event, Emitter<FamiliState> emit) async {
    final result = await repository.getFamiliData();

    if (result.error) {
      emit(FailureFamili(errorMessage: result.message));
    } else {
      List<Family> data = result.data;
      List<String> latinName = [];
      List<int> idFamili = [];

      for (var item in data) {
        latinName.add(item.latinName);
        idFamili.add(item.idFamili);
      }
      emit(GetIdLatinSuccess(idFamili: idFamili, namaLatin: latinName));
    }
  }

  Future<void> addFamiliData(
      AddDatafamiliEvent event, Emitter<FamiliState> emit) async {
    final result = await repository.addFamiliData(event.idOrdo, event.latinName,
        event.commonName, event.character, event.description, event.image);
    if (result.error) {
      emit(FailureFamili(errorMessage: result.message));
    } else {
      emit(AddDataFamiliSuccess(result: result));
    }
  }

  Future<void> updateFamiliData(
      UpdateDatafamiliEvent event, Emitter<FamiliState> emit) async {
    final result = await repository.updateFamiliData(
        event.idFamili,
        event.idOrdo,
        event.latinName,
        event.commonName,
        event.character,
        event.description,
        event.image);

    if (result.error) {
      emit(FailureFamili(errorMessage: result.message));
    } else {
      emit(UpdateFamiliSuccess(result: result));
    }
  }
}
