import 'package:biodiv/repository/spesies_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/spesies/get_spesies_data.dart';

part 'spesies_event.dart';
part 'spesies_state.dart';

class SpesiesBloc extends Bloc<SpesiesEvent, SpesiesState> {
  SpesiesBloc({required this.repository}) : super(SpesiesLoading()) {
    on<GetSpesiesData>(getAllDataSpesies);
    on<AddSpesiesDataEvent>(addDataSpesies);
    on<UpdateSpesiesDataEvent>(updateDataSpesies);
    on<GetDetailSpecies>(getDetailSpesies);
  }
  final SpesiesRepository repository;
  Future<void> getDetailSpesies(
      GetDetailSpecies event, Emitter<SpesiesState> emit) async {
    final result = await repository.getDetailSpesies(event.idSpesies);
    print(result.message);
    if (result.error) {
      emit(SpesiesFailure(errorMessage: result.message));
    } else {
      emit(GetDetailSpesiciesSuccess(result: result));
    }
  }

  Future<void> getAllDataSpesies(
      GetSpesiesData event, Emitter<SpesiesState> emit) async {
    final result = await repository.spesiesGetAll();
    if (result.error) {
      emit(SpesiesFailure(errorMessage: result.message));
    } else {
      emit(GetSpesiciesSuccess(result: result));
    }
  }

  Future<void> addDataSpesies(
      AddSpesiesDataEvent event, Emitter<SpesiesState> emit) async {
    print(event.status + event.idGenus.toString());
    final result = await repository.addOrdoData(
        event.idGenus,
        event.idCategory,
        event.latinName,
        event.commonName,
        event.habitat,
        event.status,
        event.character,
        event.description,
        event.image);
    if (result.error) {
      emit(SpesiesFailure(errorMessage: result.message));
    } else {
      emit(AddDataSuccess(result: result));
    }
  }

  Future<void> updateDataSpesies(
      UpdateSpesiesDataEvent event, Emitter<SpesiesState> emit) async {
    print(event.status + event.character);
    final result = await repository.updataeSpesiesData(
        event.idGenus,
        event.idCategory,
        event.latinName,
        event.commonName,
        event.habitat,
        event.status,
        event.character,
        event.description,
        event.image,
        event.idSpesies);
    if (result.error) {
      emit(SpesiesFailure(errorMessage: result.message));
    } else {
      emit(AddDataSuccess(result: result));
    }
  }
}
