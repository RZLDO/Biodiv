import 'package:biodiv/repository/analysa_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/analysa model/analysa_model.dart';

part 'analysa_event.dart';
part 'analysa_state.dart';

class AnalysaBloc extends Bloc<AnalysaEvent, AnalysaState> {
  AnalysaBloc({required this.repository}) : super(AnalysaInitial()) {
    on<GetAnalysaEvent>(getAnalysaData);
  }

  final AnalysaRepository repository;

  Future getAnalysaData(
      GetAnalysaEvent event, Emitter<AnalysaState> emit) async {
    final result = await repository.getAnalysaData(event.idSpesies);
    if (result.error) {
      emit(GetAnalysaStateFailure(message: result.message));
    } else {
      Map<String, List<AnalysisData>> groupedData = {};

      for (var entry in result.result) {
        String month = entry.bulan;
        String location = entry.namaLokasi;

        if (!groupedData.containsKey(location)) {
          groupedData[location] = [];
        }

        groupedData[location]!.add(entry);
      }
      emit(GetAnalysaStateSuccess(result: groupedData));
    }
  }
}
