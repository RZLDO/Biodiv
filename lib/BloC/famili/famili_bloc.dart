import 'package:biodiv/model/famili%20model/famili_model.dart';
import 'package:biodiv/repository/famili_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'famili_state.dart';
part 'famili_event.dart';

class FamiliBloc extends Bloc<FamiliEvent, FamiliState> {
  FamiliBloc({required this.repository}) : super(FamiliLoading()) {
    on<GetFamiliEvent>(getDataFamili);
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
}
