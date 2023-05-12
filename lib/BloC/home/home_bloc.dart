import 'package:biodiv/model/user_model.dart';
import 'package:biodiv/repository/home_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:biodiv/model/total_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.homeRepository}) : super(HomeInitial()) {
    on<GetTotalData>(fetchDataTostate);
  }

  final HomeRepository homeRepository;
  Future<void> fetchDataTostate(
      GetTotalData event, Emitter<HomeState> emit) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await homeRepository.getTotalData();
    final String? name = preferences.getString('name');
    final String? level = preferences.getString('level');
    final String? token = preferences.getString('token');
    final int? id = preferences.getInt('id');
    final usermodel = UserModel(id: id, name: name, level: level, token: token);
    if (response.error == true) {
      emit(GetAllFailure(errorMessage: response.message));
    } else {
      final data = response.data;
      final List<int?> listItems = [
        data!.classCount,
        data.ordoCount,
        data.familiCount,
        data.genusCount,
        data.spesiesCount,
      ];
      emit(GetAllSuccess(
          response: response, userModel: usermodel, taksonData: listItems));
    }
  }
}
