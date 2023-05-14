import 'package:biodiv/model/get_ordo_model.dart';
import 'package:biodiv/repository/ordo_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

part 'ordo_event.dart';
part 'ordo_state.dart';

class OrdoBloc extends Bloc<OrdoEvent, OrdoState> {
  @override
  OrdoBloc({required this.repository}) : super(OrdoLoading()) {
    on<GetOrdoData>(getOrdoData);
  }

  final OrdoRepository repository;

  Future<void> getOrdoData(GetOrdoData event, Emitter<OrdoState> emit) async {
    final response = await repository.getOrdoData();
    if (response.error == true) {
      emit(Failure(errorMessage: response.message));
    } else {
      emit(Success(response: response));
    }
  }
}
