import 'dart:ffi';

import 'package:biodiv/model/famili%20model/delete_famili.dart';
import 'package:biodiv/model/famili%20model/detai_famili_mode.dart';
import 'package:biodiv/model/famili%20model/famili_model.dart';
import 'package:biodiv/repository/famili_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'famili_state.dart';
part 'famili_event.dart';

class FamiliBloc extends Bloc<FamiliEvent, FamiliState> {
  FamiliBloc({required this.repository}) : super(FamiliLoading()) {
    on<GetFamiliEvent>(getDataFamili);
    on<GetFamiliDetailevent>(getDetailFamili);
    on<DeleteFamiliEvent>(deleteFamili);
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
}
