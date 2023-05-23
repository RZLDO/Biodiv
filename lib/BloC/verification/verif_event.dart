part of 'verif_bloc.dart';

abstract class VerifEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUnverifiedData extends VerifEvent {}
