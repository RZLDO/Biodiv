import 'package:biodiv/repository/verification_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verif_event.dart';
part 'verif_state.dart';

class VerifBloc extends Bloc<VerifEvent, VerifState> {
  VerifBloc({required this.repository}) : super(VerifLoadingState()) {
    on<GetUnverifiedData>(getUnverifiedData);
  }
  final VerificationRepository repository;

  Future<void> getUnverifiedData(
      GetUnverifiedData event, Emitter<VerifState> emit) async {
    final result = await repository.getTotalUnverifiedData();
    if (result.error) {
      emit(VerifFailure(errorMessage: result.message));
    } else {
      final data = result.data;
      final List<int?> ListData = [
        data!.classCount,
        data.ordoCount,
        data.genusCount,
        data.familyCount,
        data.speciesCount,
        data.totalData,
      ];
      emit(GetUnverifiedDataSuccess(
        data: ListData,
      ));
    }
  }
}
