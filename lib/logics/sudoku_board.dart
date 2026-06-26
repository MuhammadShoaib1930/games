import 'package:flutter/material.dart';
import 'package:games/logics/sudoku_game.dart';

class SudokuBoard {
  Color selectedColor({required int index, required int selectedIndex}) {
    if (selectedIndex == 0) {
      return Colors.white;
    }
    if (selectedIndex == index) {
      return Colors.blue;
    }
    int row = index ~/ 9;
    int col = index % 9;
    int selectedRow = selectedIndex ~/ 9;
    int selectedCol = selectedIndex % 9;
    if (row == selectedRow || col == selectedCol) {
      return Colors.grey;
    }
    if (row ~/ 3 == selectedRow ~/ 3 && col ~/ 3 == selectedCol ~/ 3) {
      return Colors.grey;
    }
    return Colors.white;
  }

  Color textColor(int index, List<List<int>> solvedBoard, List<List<int>> unSolvedBoard) {
    int row = SudokuGame().indexToRow(index);
    int col = SudokuGame().indexToCol(index);
    if (solvedBoard[row][col] == unSolvedBoard[row][col] || unSolvedBoard[row][col] == 0) {
      return Colors.black;
    }
    return Colors.red;
  }

  Border border(int index) {
    return Border(
      top: BorderSide(width: (index ~/ 9) % 3 == 0 ? 2 : 0.5),
      left: BorderSide(width: (index % 9) % 3 == 0 ? 2 : 0.5),
      right: BorderSide(width: ((index % 9) + 1) % 3 == 0 ? 2 : 0.5),
      bottom: BorderSide(width: ((index ~/ 9) + 1) % 3 == 0 ? 2 : 0.5),
    );
  }
}
