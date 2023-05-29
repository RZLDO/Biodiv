import 'package:biodiv/model/scarcity/scarcity.dart';
import 'package:biodiv/model/verif%20model/verif_model.dart';
import 'package:biodiv/repository/scarcity_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'scarcity_event.dart';
part 'scarcity_state.dart';

class ScarcityBloc extends Bloc<ScarcityEvent, ScarcityState> {
  ScarcityBloc({required this.repository}) : super(ScarcityLoading()) {
    on<GetScarcityId>(getScarcity);
    on<GetTotalScarcity>(getTotalScarcity);
    on<GetScarcityData>(getAllScarcity);
  }

  final ScarcityRepository repository;
  Future<void> getAllScarcity(
      GetScarcityData event, Emitter<ScarcityState> emit) async {
    final data = await repository.getScarcity();
    final result = await repository.getTotalScarcity();
    if (result.error || data.error) {
      emit(ScarcityFailure(errorMessage: result.message));
    } else {
      final List<ScarcityDataModel> dataScarcity = result.data;
      final List<ScarcityModelChart> listData = [];

      for (var i = 1; i <= 9; i++) {
        var count = 0;
        for (var item in dataScarcity) {
          if (item.idKategori == i) {
            count = item.count;
            break;
          }
        }
        final dataModel = ScarcityModelChart(idKelangkaan: i, count: count);
        listData.add(dataModel);
      }
      emit(ScarcitySuccess(data: data, result: listData));
    }
  }

  Future<void> getScarcity(
      GetScarcityId event, Emitter<ScarcityState> emit) async {
    final result = await repository.getScarcity();
    if (result.error) {
      emit(ScarcityFailure(errorMessage: result.message));
    } else {
      List<ConservationStatus> data = result.data;
      List<String> scarcityName = [];
      List<int> idScarcity = [];
      for (var item in data) {
        scarcityName.add(item.nama);
        idScarcity.add(item.idKategori);
      }
      emit(GetIdScarcity(idScarcity: idScarcity, nameScarcity: scarcityName));
    }
  }

  Future<void> getTotalScarcity(
      GetTotalScarcity event, Emitter<ScarcityState> emit) async {
    final result = await repository.getTotalScarcity();

    if (result.error) {
      emit(ScarcityFailure(errorMessage: result.message));
    } else {
      final List<ScarcityDataModel> data = result.data;
      final List<ScarcityModelChart> listData = [];

      for (var i = 1; i <= 9; i++) {
        var count = 0;
        for (var item in data) {
          if (item.idKategori == i) {
            count = item.count;
            break;
          }
        }
        final dataModel = ScarcityModelChart(idKelangkaan: i, count: count);
        listData.add(dataModel);
      }

      emit(GetTotalScarcitySuccess(result: listData));
    }
  }
}
