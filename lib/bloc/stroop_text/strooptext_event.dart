part of 'strooptext_bloc.dart';

sealed class StrooptextEvent extends Equatable {
  const StrooptextEvent();

  @override
  List<Object> get props => [];
}

class Solved extends StrooptextEvent {
  final int scoreText;
  final int scoreEffect;
  final int userSelected;
  const Solved({required this.userSelected, required this.scoreText, required this.scoreEffect});
  @override
  List<Object> get props => [userSelected, scoreEffect, scoreText];
}

class InitalStropText extends StrooptextEvent {}

class StartTimer extends StrooptextEvent {}

class ResetTimer extends StrooptextEvent {}

class Tick extends StrooptextEvent {}
