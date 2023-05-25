import 'package:biodiv/model/Class%20Model/get_class_model.dart';
import 'package:biodiv/model/famili%20model/famili_model.dart';
import 'package:biodiv/model/genus/get_data_genus.dart';
import 'package:biodiv/model/get_ordo_model.dart';
import 'package:biodiv/repository/verification_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/verif model/verif_success.dart';

part 'verif_event.dart';
part 'verif_state.dart';

class VerifBloc extends Bloc<VerifEvent, VerifState> {
  VerifBloc({required this.repository}) : super(VerifLoadingState()) {
    on<GetUnverifiedData>(getUnverifiedData);
    on<GetUnverifClass>(getUnverifiedClass);
    on<GetUnverifGenus>(getUnverifiedGenus);
    on<GetUnverifOrdo>(getUnverifiedOrdo);
    on<GetUnverifFamili>(getUnverifiedFamili);
    on<VerifClassEvent>(verifiedClass);
    on<DeleteUnverifEvent>(deleteClass);
  }
  final VerificationRepository repository;
  Future<void> deleteClass(
      DeleteUnverifEvent event, Emitter<VerifState> emit) async {
    final result = await repository.DeleteUnverifClass(event.id, event.path);
    if (result.error) {
      emit(DeleteFailure(errorMessage: result.message));
    } else {
      emit(DeleteUnverifSuccess(result: result));
    }
  }

  Future<void> verifiedClass(
      VerifClassEvent event, Emitter<VerifState> emit) async {
    final result = await repository.verifClass(event.id, event.path);
    print(result.message);
    if (result.error) {
      emit(VerificationFailure(errorMessage: result.message));
    } else {
      emit(VerifSuccess(result: result));
    }
  }

  Future<void> getUnverifiedData(
      GetUnverifiedData event, Emitter<VerifState> emit) async {
    final result = await repository.getTotalUnverifiedData();
    if (result.error) {
      emit(VerifFailure(errorMessage: result.message));
    } else {
      final data = result.data;
      final List<int?> listData = [
        data!.classCount,
        data.ordoCount,
        data.genusCount,
        data.familyCount,
        data.speciesCount,
        data.totalData,
      ];
      emit(GetUnverifiedDataSuccess(
        data: listData,
      ));
    }
  }

  Future<void> getUnverifiedClass(
      GetUnverifClass event, Emitter<VerifState> emit) async {
    final result = await repository.getClassUnverified();
    if (result.error) {
      emit(VerifFailure(errorMessage: result.message));
    } else {
      emit(GetUnverifiedClassSuccess(result: result));
    }
  }

  Future<void> getUnverifiedGenus(
      GetUnverifGenus event, Emitter<VerifState> emit) async {
    final result = await repository.getGenusUnverified();
    if (result.error) {
      emit(VerifFailure(errorMessage: result.message));
    } else {
      emit(GetUnverifiedGenusSuccess(result: result));
    }
  }

  Future<void> getUnverifiedOrdo(
      GetUnverifOrdo event, Emitter<VerifState> emit) async {
    final result = await repository.getOrdoUnverified();
    print(result.data);
    if (result.error) {
      emit(VerifFailure(errorMessage: result.message));
    } else {
      emit(GetUnverifiedOrdoSuccess(result: result));
    }
  }

  Future<void> getUnverifiedFamili(
      GetUnverifFamili event, Emitter<VerifState> emit) async {
    final result = await repository.getFamiliUnverified();
    if (result.error) {
      emit(VerifFailure(errorMessage: result.message));
    } else {
      emit(GetUnverifiedFamili(result: result));
    }
  }
}
