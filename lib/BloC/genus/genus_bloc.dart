import 'package:biodiv/model/genus/add_data_genus.dart';
import 'package:biodiv/model/genus/delele_genus_model.dart';
import 'package:biodiv/model/genus/get_data_genus.dart';
import 'package:biodiv/repository/genus_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
part 'genus_state.dart';
part 'genus_event.dart';

class GenusBloc extends Bloc<GenusEvent, GenusState> {
  GenusBloc({required this.repository}) : super(GenusLoading()) {
    on<GetDataGenusEvent>(getGenusData);
    on<GetDetailGenusEvent>(getDetailGenusData);
    on<DeleteGenusEvent>(deleteGenus);
    on<AddDataGenusEvent>(addGenusData);
    on<UpdateDataGenusEvent>(updateGenusData);
    on<GetIdLatinGenusEvent>(getIdLatinGenus);
  }
  final GenusRepository repository;
  Future<void> getGenusData(
      GetDataGenusEvent event, Emitter<GenusState> emit) async {
    final result = await repository.getGenusData();

    if (result.error == true) {
      emit(GenusFailure(errorMessage: result.message));
    } else {
      emit(GetGenusDataSuccess(result: result));
    }
  }

  Future<void> getDetailGenusData(
      GetDetailGenusEvent event, Emitter<GenusState> emit) async {
    final result = await repository.getDetailGenusData(event.idGenus);

    if (result.error == true) {
      emit(GenusFailure(errorMessage: result.message));
    } else {
      emit(GetGenusDetailDataSuccess(result: result));
    }
  }

  Future<void> deleteGenus(
      DeleteGenusEvent event, Emitter<GenusState> emit) async {
    final result = await repository.deleteGenusData(event.idGenus);
    if (result.error) {
      emit(GenusFailure(errorMessage: result.message));
    } else {
      emit(DeleteGenusSuccess(result: result));
    }
  }

  Future<void> getIdLatinGenus(
      GetIdLatinGenusEvent event, Emitter<GenusState> emit) async {
    final result = await repository.getGenusData();

    if (result.error) {
      emit(GenusFailure(errorMessage: result.message));
    } else {
      List<GenusData> data = result.data;
      List<String> latinName = [];
      List<int> idGenus = [];
      for (var item in data) {
        latinName.add(item.namaLatin);
        idGenus.add(item.idGenus);
      }
      emit(GetIdLatinGenusSuccess(idGenus: idGenus, latinName: latinName));
    }
  }

  Future<void> addGenusData(
      AddDataGenusEvent event, Emitter<GenusState> emit) async {
    final result = await repository.addGenusRepository(
        event.idFamili,
        event.latinName,
        event.commonName,
        event.characterteristics,
        event.description,
        event.image);
    if (result.error) {
      emit(GenusFailure(errorMessage: result.message));
    } else {
      emit(AddDataGenusSuccess(result: result));
    }
  }

  Future<void> updateGenusData(
      UpdateDataGenusEvent event, Emitter<GenusState> emit) async {
    final result = await repository.updateGenusRepository(
        event.idGenus,
        event.idFamili,
        event.latinName,
        event.commonName,
        event.characterteristics,
        event.description,
        event.image);
    if (result.error) {
      emit(GenusFailure(errorMessage: result.message));
    } else {
      emit(UpdateGenusSuccess(result: result));
    }
  }
}
