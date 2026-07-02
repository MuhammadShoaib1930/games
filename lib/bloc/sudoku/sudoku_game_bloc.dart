import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games/logics/sudoku_game.dart';
import 'package:games/models/sudoku_model.dart';
import 'package:games/services/hive_service.dart';

part 'sudoku_game_event.dart';
part 'sudoku_game_state.dart';

class SudokuGameBloc extends Bloc<SudokuGameEvent, SudokuGameState> {
  final HiveService hiveService = HiveService();
  final SudokuGame sudokuGame = SudokuGame();
  SudokuGameBloc() : super(SudokuGameState()) {
    on<Refresh>(_refresh);
    on<SelectValue>(_selectValue);
    on<SelectIndex>(_selectIndex);
    on<IsFillByValue>(_isFillByValue);
    on<LevelUpdate>(_levelUpdate);
    on<Tries>(_tries);
    on<Remove>(_remove);
    // on<Hint>(_hint);
  }

  FutureOr<void> _refresh(Refresh event, Emitter<SudokuGameState> emit) {
    sudokuGame.sudokuGenerate(state.difficulty);

    final SudokuModel sudokuModel = HiveService().getSudoku();
    sudokuGame.sudokuGenerate(sudokuModel.difficulty);
    emit(
      state.copyWith(
        unsolvedBoard: sudokuGame.unSolvedBoard,
        score: sudokuModel.score,
        difficulty: sudokuModel.difficulty,
        tries: sudokuModel.tries,
        level: sudokuModel.level,
      ),
    );
  }

  FutureOr<void> _selectValue(SelectValue event, Emitter<SudokuGameState> emit) {
    SudokuGameState newState = state.copyWith(selectedValue: event.value);
    if (state.selectedValue != event.value) {
      newState = newState.copyWith(selectedValue: event.value);

      if (!state.byValueFill && state.selectedIndex != -1) {
        newState = fillBoard(newState);
      }
    }
    if (sudokuGame.solved()) {
      hiveService.updateSudoku(level: state.level+1, score: state.score+10, tries: state.tries,);
      add(LevelUpdate());
    } else {
      emit(newState);
    }
  }

  FutureOr<void> _selectIndex(SelectIndex event, Emitter<SudokuGameState> emit) {
    emit(state.copyWith(selectedIndex: -1));
    SudokuGameState newState = state.copyWith(selectedIndex: event.index);

    if (newState.byValueFill && newState.selectedValue != 0) {
      newState = fillBoard(newState);
    }
    if (sudokuGame.solved()) {
      hiveService.updateSudoku(level: state.level, score: state.score, tries: state.tries);
      add(LevelUpdate());
    } else {
      emit(newState);
    }
  }

  SudokuGameState fillBoard(SudokuGameState state) {
    bool isCorrect;
    int score;
    (isCorrect, score) = sudokuGame.addData(state.selectedIndex, state.selectedValue);

    return state.copyWith(
      unsolvedBoard: sudokuGame.unSolvedBoard,
      score: (isCorrect) ? (state.score) + score : null,
      tries: (isCorrect) ? null : state.tries - 1,
    );
  }

  FutureOr<void> _isFillByValue(IsFillByValue event, Emitter<SudokuGameState> emit) {
    emit(state.copyWith(byValueFill: !state.byValueFill));
  }

  FutureOr<void> _levelUpdate(LevelUpdate event, Emitter<SudokuGameState> emit) {
    SudokuGameState newState = state.copyWith(difficulty: state.difficulty + 10);
    sudokuGame.sudokuGenerate(newState.difficulty);
    newState = newState.copyWith(
      unsolvedBoard: sudokuGame.unSolvedBoard,
      level: state.level + 1,
      selectedIndex: -1,
      selectedValue: 0,
    );
    emit(newState);
  }

  FutureOr<void> _tries(Tries event, Emitter<SudokuGameState> emit) {
    emit(state.copyWith(tries: state.tries + 1));
  }

  FutureOr<void> _remove(Remove event, Emitter<SudokuGameState> emit) {
    int selectIndex = state.selectedIndex;
    emit(state.copyWith(selectedIndex: -1));
    List<List<int>> board = sudokuGame.remove(selectIndex, state.unsolvedBoard);
    if (state.selectedIndex >= 0) {
      emit(state.copyWith(unsolvedBoard: board, selectedIndex: selectIndex));
    }
  }

  // FutureOr<void> _hint(Hint event, Emitter<SudokuGameState> emit) {
  //   int index = state.selectedIndex;
  //   sudokuGame.hint(state.unsolvedBoard);
  //   emit(state.copyWith(selectedIndex: -1));
  //   emit(
  //     state.copyWith(selectedIndex: index, hintData: sudokuGame.hintData, isHint: !state.isHint),
  //   );
  // }
}
