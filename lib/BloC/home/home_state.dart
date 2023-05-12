part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class GetAllSuccess extends HomeState {
  final TotalDataResponse response;
  final UserModel userModel;
  final List<int?> taksonData;
  GetAllSuccess(
      {required this.response,
      required this.userModel,
      required this.taksonData});

  @override
  List<Object?> get props => [response, userModel, taksonData];
}

class GetAllFailure extends HomeState {
  final String errorMessage;

  GetAllFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
