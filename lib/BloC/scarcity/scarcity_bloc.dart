import 'package:biodiv/model/scarcity/scarcity.dart';
import 'package:biodiv/repository/scarcity_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'scarcity_event.dart';
part 'scarcity_state.dart';

class ScarcityBloc extends Bloc<ScarcityEvent, ScarcityState> {
  ScarcityBloc({required this.repository}) : super(ScarcityLoading()) {
    on<GetScarcityId>(getScarcity);
  }

  final ScarcityRepository repository;

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
}
