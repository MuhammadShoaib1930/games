import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games/logics/magic_square_logic.dart';
import 'package:games/models/magic_square.dart';
import 'package:games/services/hive_service.dart';

part 'magic_square_event.dart';
part 'magic_square_state.dart';

class MagicSquareBloc extends Bloc<MagicSquareEvent, MagicSquareState> {
  MagicSquareLogic magicSquareLogic = MagicSquareLogic();
  MagicSquareBloc() : super(MagicSquareState()) {
    on<SelectValue>(_selectValue);
    on<Fill>(_fill);
    on<Inital>(_inital);
    on<Remove>(_isRemove);
  }

  FutureOr<void> _selectValue(SelectValue event, Emitter<MagicSquareState> emit) {
    emit(state.copyWith(value: event.value));
  }

  FutureOr<void> _fill(Fill event, Emitter<MagicSquareState> emit) {
    if (state.isRemove) {
      List<List<int>> newBoard = [];
      List<int> newlist = [];
      (newBoard, newlist) = magicSquareLogic.removeElement(
        state.unSolvedBoard,
        state.removeList,
        event.index,
      );
      emit(state.copyWith(unSolvedBoard: newBoard, removeList: newlist, value: 0, isRemove: false));
    } else {
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
          HiveService hiveService = HiveService();
          hiveService.updateBoxData(
            box: hiveService.magicSquareBox,
            score: (state.score == 0) ? state.score + 10 : state.score * 2,
            level: state.level + 1,
          );
          (newBoard, newList) = magicSquareLogic.generateBoard(state.level + 1);
          emit(
            state.copyWith(
              value: 0,
              level: state.level + 1,
              removeList: newList,
              unSolvedBoard: newBoard,
              score: (state.score == 0) ? state.score + 10 : state.score * 2,
            ),
          );
        } else {
          (newBoard, newList) = magicSquareLogic.generateBoard(1);
          emit(state.copyWith(value: 0, level: 1, removeList: newList, unSolvedBoard: newBoard));
          HiveService().updateBoxData<MagicSquare>(
            box: HiveService().magicSquareBox,
            score: 0,
            level: 1,
          );
          add(Inital());
        }
      } else {
        emit(state.copyWith(unSolvedBoard: newBoard, removeList: newList, value: 0));
      }
    }
  }

  FutureOr<void> _inital(Inital event, Emitter<MagicSquareState> emit) {
    List<List<int>> newBoard = [];
    List<int> newList = [];
    HiveService hiveService = HiveService();
    MagicSquare magicSquare = hiveService.getDataFormBox<MagicSquare>(
      box: hiveService.magicSquareBox,
    );
    (newBoard, newList) = magicSquareLogic.generateBoard(magicSquare.level);
    emit(
      MagicSquareState(
        level: magicSquare.level,
        removeList: newList,
        unSolvedBoard: newBoard,
        value: 0,
        score: magicSquare.score,
      ),
    );
  }

  FutureOr<void> _isRemove(Remove event, Emitter<MagicSquareState> emit) {
    emit(state.copyWith(isRemove: !state.isRemove));
  }
}
