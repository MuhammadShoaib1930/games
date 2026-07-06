import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games/logics/magic_square_logic.dart';

part 'magic_square_event.dart';
part 'magic_square_state.dart';

class MagicSquareBloc extends Bloc<MagicSquareEvent, MagicSquareState> {
  MagicSquareLogic magicSquareLogic = MagicSquareLogic();
  MagicSquareBloc() : super(MagicSquareState()) {
    on<SelectValue>(_selectValue);
    on<Fill>(_fill);
    on<Inital>(_inital);
  }

  FutureOr<void> _selectValue(SelectValue event, Emitter<MagicSquareState> emit) {
    emit(state.copyWith(value: event.value));
  }

  FutureOr<void> _fill(Fill event, Emitter<MagicSquareState> emit) {
    List<List<int>> newBoard = [];
    List<int> newList = [];
    (newBoard, newList) = magicSquareLogic.addElements(
      state.unSolvedBoard,
      event.index,
      state.value,
      state.removeList,
    );

    if (state.removeList.isEmpty) {
      if (magicSquareLogic.isFilledCorrect(newBoard)) {
      (newBoard, newList) = magicSquareLogic.generateBoard(state.level + 1);
        emit(
          state.copyWith(
            value: 0,
            level: state.level + 1,
            removeList: newList,
            unSolvedBoard: newBoard,
          ),
        );
      } else {
      (newBoard, newList) = magicSquareLogic.generateBoard(1);
        emit(
          state.copyWith(
            value: 0,
            level: 1,
            removeList: newList,
            unSolvedBoard: newBoard,
          ),
        );
        add(Inital());
      }
    } else {
      emit(state.copyWith(unSolvedBoard: newBoard, removeList: newList, value: 0));
    }
  }

  FutureOr<void> _inital(Inital event, Emitter<MagicSquareState> emit) {
    List<List<int>> newBoard = [];
    List<int> newList = [];
    (newBoard, newList) = magicSquareLogic.generateBoard(state.level);
    emit(MagicSquareState(level: 1, removeList: newList, unSolvedBoard: newBoard, value: 0));
  }
}
