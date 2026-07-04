import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:games/models/app_settings.dart';
import 'package:games/services/hive_service.dart';

class MagicSquareLogic {
  static final MagicSquareLogic _instance = MagicSquareLogic._internal();
  MagicSquareLogic._internal();
  factory MagicSquareLogic() => _instance;
  List<List<int>> solvedBoard = [
    [8, 1, 6],
    [3, 5, 7],
    [4, 9, 2],
  ];
  List<List<int>> unsolvedBoard = [];
  List<int> removeList = [];
  void generateBoard(int diffecalty) {
    diffecalty %= 3;
    int r = 0, c = 0;
    while (r == c) {
      r = Random().nextInt(3);
      c = Random().nextInt(3);
    }
    for (var i = 0; i < r; i++) {
      solvedBoard = _swapRow(solvedBoard);
    }
    for (var i = 0; i < c; i++) {
      solvedBoard = _swapCol(solvedBoard);
    }
    unsolvedBoard = copyBoard(solvedBoard);
    _removeElements(9);
    printF(unsolvedBoard);
  }

  List<List<int>> _swapRow(List<List<int>> board) {
    for (var i = 0; i < 3; i++) {
      board[i][0] = board[i][0] ^ board[i][2];
      board[i][2] = board[i][0] ^ board[i][2];
      board[i][0] = board[i][0] ^ board[i][2];
    }
    return copyBoard(board);
  }

  List<List<int>> _swapCol(List<List<int>> board) {
    for (var i = 0; i < 3; i++) {
      board[0][i] = board[0][i] ^ board[2][i];
      board[2][i] = board[0][i] ^ board[2][i];
      board[0][i] = board[0][i] ^ board[2][i];
    }
    return copyBoard(board);
  }

  void printF(List<List<int>> s) {
    for (var i = 0; i < 3; i++) {
      String st = "";
      for (var j = 0; j < 3; j++) {
        st += "${s[i][j]} ";
      }
      print(st);
    }
  }

  List<List<int>> copyBoard(List<List<int>> board) {
    return board.map((row) => List<int>.from(row)).toList();
  }

  String boardValueToString(int index, List<List<int>> board) {
    int row, col;
    (row, col) = indexToRC(index);
    if (board[row][col] == 0) {
      return "";
    } else {
      return "${board[row][col]}";
    }
  }

  (int, int) indexToRC(int index) => ((index ~/ 9), (index % 9));

  void _removeElements(int removeElementsNo) {
    removeList.clear();
    removeElementsNo = (removeElementsNo >= 8) ? 7 : removeElementsNo;
    Random random = Random();
    while (removeElementsNo > 0) {
      int r = random.nextInt(3);
      int c = random.nextInt(3);
      if (unsolvedBoard[r][c] != 0) {
        removeList.add(unsolvedBoard[r][c]);
        unsolvedBoard[r][c] = 0;
        removeElementsNo--;
      }
    }
  }

  Color textColor(int index, List<List<int>> solvedBoard, List<List<int>> unSolvedBoard) {
    final isDark = HiveService().getDataFormBox<AppSettings>(box: HiveService().settingBox).isDark;
    int row, col;
    (row, col) = indexToRC(index);
    if (solvedBoard[row][col] == unSolvedBoard[row][col] || unSolvedBoard[row][col] == 0) {
      return (isDark) ? Colors.white : Colors.black;
    }
    return Colors.red;
  }

  Border border(int index) {
    return Border(
      top: BorderSide(width: index ~/ 3 == 0 ? 2 : 0.5),
      left: BorderSide(width: index % 3 == 0 ? 2 : 0.5),
      right: BorderSide(width: index % 3 == 2 ? 2 : 0.5),
      bottom: BorderSide(width: index ~/ 3 == 2 ? 2 : 0.5),
    );
  }
}
