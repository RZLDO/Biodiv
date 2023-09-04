part of 'class_bloc.dart';

abstract class ClassState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ClassInitial extends ClassState {}

class ClassLoading extends ClassState {}

class GetDataSuccess extends ClassState {
  final List<ClassData> dataClass;

  GetDataSuccess({required this.dataClass});

  @override
  List<Object?> get props => [dataClass];
}

class Failure extends ClassState {
  final String errorMessage;

  Failure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class AddDataSuccess extends ClassState {
  final AddClassDataModel postDataClass;
  AddDataSuccess({required this.postDataClass});

  @override
  List<Object?> get props => [postDataClass];
}

class DetailSuccess extends ClassState {
  final DetailResponse detail;
  DetailSuccess({required this.detail});

  @override
  List<Object?> get props => [detail];
}

class DeleteSuccess extends ClassState {
  final UpdateDataClass? response;

  DeleteSuccess({this.response});
  @override
  List<Object?> get props => [response];
}

class DeleteFailure extends ClassState {
  final String message;
  DeleteFailure({required this.message});
  @override
  List<Object?> get props => [message];
}

class EditSuccess extends ClassState {
  final UpdateDataClass response;

  EditSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

class GetIdClassSucces extends ClassState {
  final List<String> latinName;
  final List<int> idClass;

  GetIdClassSucces({required this.idClass, required this.latinName});

  @override
  List<Object?> get props => [latinName, idClass];
}
