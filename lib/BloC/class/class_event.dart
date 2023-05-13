part of 'class_bloc.dart';

abstract class ClassEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetDataClass extends ClassEvent {}
