part of 'strooptext_bloc.dart';

sealed class StrooptextEvent extends Equatable {
  const StrooptextEvent();

  @override
  List<Object> get props => [];
}

class Solved extends StrooptextEvent {
  final bool isText;
  final int userSelected;
  const Solved({required this.userSelected, required this.isText});
  @override
  List<Object> get props => [userSelected, isText];
}

class InitalStropText extends StrooptextEvent {}

class StartTimer extends StrooptextEvent {}

class ResetTimer extends StrooptextEvent {}

class Tick extends StrooptextEvent {}
