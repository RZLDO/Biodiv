part of 'genus_bloc.dart';

abstract class GenusEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetDataGenusEvent extends GenusEvent {}
