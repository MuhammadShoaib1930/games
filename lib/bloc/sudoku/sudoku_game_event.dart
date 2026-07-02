part of 'sudoku_game_bloc.dart';

sealed class SudokuGameEvent extends Equatable {
  const SudokuGameEvent();

  @override
  List<Object> get props => [];
}

final class IsFillByValue extends SudokuGameEvent {}

final class SelectValue extends SudokuGameEvent {
  final int value;
  const SelectValue({required this.value});
  @override
  List<Object> get props => [value];
}

final class SelectIndex extends SudokuGameEvent {
  final int index;
  const SelectIndex({required this.index});
  @override
  List<Object> get props => [index];
}

final class Refresh extends SudokuGameEvent {}

final class Remove extends SudokuGameEvent {}

final class LevelUpdate extends SudokuGameEvent {}

final class Tries extends SudokuGameEvent {}

final class Hint extends SudokuGameEvent {}
