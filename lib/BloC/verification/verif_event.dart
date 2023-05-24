part of 'verif_bloc.dart';

abstract class VerifEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUnverifiedData extends VerifEvent {}

class GetUnverifClass extends VerifEvent {}

class GetUnverifGenus extends VerifEvent {}

class GetUnverifOrdo extends VerifEvent {}

class GetUnverifFamili extends VerifEvent {}
