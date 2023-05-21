import 'package:biodiv/model/genus/get_data_genus.dart';
import 'package:biodiv/repository/genus_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'genus_state.dart';
part 'genus_event.dart';

class GenusBloc extends Bloc<GenusEvent, GenusState> {
  GenusBloc({required this.repository}) : super(GenusLoading()) {
    on<GetDataGenusEvent>(getGenusData);
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
}
