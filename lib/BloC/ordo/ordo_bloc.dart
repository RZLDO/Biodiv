import 'package:biodiv/model/get_ordo_model.dart';
import 'package:biodiv/model/ordo%20model/detail_ordo_model.dart';
import 'package:biodiv/repository/ordo_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'ordo_event.dart';
part 'ordo_state.dart';

class OrdoBloc extends Bloc<OrdoEvent, OrdoState> {
  @override
  OrdoBloc({required this.repository}) : super(OrdoLoading()) {
    on<GetOrdoData>(getOrdoData);
    on<GetDetailOrdoEvent>(getDetailOrdo);
    on<AddOrdoEvent>(addOrdoData);
    on<DeleteOrdoEvent>(deleteOrdoData);
    on<UpdateOrdoEvent>(updateOrdodata);
  }

  final OrdoRepository repository;
  Future<void> getDetailOrdo(
      GetDetailOrdoEvent event, Emitter<OrdoState> emit) async {
    emit(OrdoLoading());
    final response = await repository.getDetailOrdo(event.idOrdo);
    if (response.error == true) {
      emit(FailureOrdo(errorMessage: response.message));
    } else {
      emit(DetailStateSuccess(response: response));
    }
  }

  Future<void> getOrdoData(GetOrdoData event, Emitter<OrdoState> emit) async {
    final response = await repository.getOrdoData();
    if (response.error == true) {
      emit(FailureOrdo(errorMessage: response.message));
    } else {
      emit(Success(response: response));
    }
  }

  Future<void> addOrdoData(AddOrdoEvent event, Emitter<OrdoState> emit) async {
    final response = await repository.addOrdoData(
        event.idClass,
        event.latinName,
        event.commonName,
        event.character,
        event.description,
        event.image);
    if (response.error == true) {
      emit(FailureOrdo(errorMessage: response.message));
    } else {
      emit(AddOrdoSuccess(response: response));
    }
  }

  Future<void> deleteOrdoData(
      DeleteOrdoEvent event, Emitter<OrdoState> emit) async {
    final result = await repository.deleteOrdo(event.idOrdo);
    if (result.error) {
      emit(FailureOrdo(errorMessage: result.message));
    } else {
      emit(DeleteOrdoStateSuccess(response: result));
    }
  }

  Future<void> updateOrdodata(
      UpdateOrdoEvent event, Emitter<OrdoState> emit) async {
    final result = await repository.updateOrdo(
        event.idOrdo,
        event.latinName,
        event.commonName,
        event.character,
        event.description,
        event.idClass,
        event.image);
    print(result.message);
    emit(UpdateOrdoStateSuccess(response: result));
  }
}
