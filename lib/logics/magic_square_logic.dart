import 'dart:math';

import 'package:flutter/material.dart';

class MagicSquareLogic {
  (List<List<int>>, List<int>) generateBoard(int diffecalty) {
    List<List<int>> baseBoard = [
      [8, 1, 6],
      [3, 5, 7],
      [4, 9, 2],
    ];
    diffecalty = (diffecalty >= 9) ? 8 : diffecalty;
    return _removeElements(diffecalty, _swapRow(baseBoard));
  }

  List<List<int>> _swapRow(List<List<int>> board) {
    int r = 0, c = 0;
    while (r == c) {
      r = Random().nextInt(3);
      c = Random().nextInt(3);
    }

    for (var i = 0; i < r; i++) {
      for (var i = 0; i < 3; i++) {
        board[i][0] = board[i][0] ^ board[i][2];
        board[i][2] = board[i][0] ^ board[i][2];
        board[i][0] = board[i][0] ^ board[i][2];
      }
    }
    for (var i = 0; i < c; i++) {
      for (var i = 0; i < 3; i++) {
        board[0][i] = board[0][i] ^ board[2][i];
        board[2][i] = board[0][i] ^ board[2][i];
        board[0][i] = board[0][i] ^ board[2][i];
      }
    }
    return (board);
  }

  bool isFilledCorrect(List<List<int>> unsolvedBoard) {
    int rows = 0, column = 0, diagnal1 = 0, diagnal2 = 0;
    for (var i = 0; i < 3; i++) {
      rows += unsolvedBoard[0][i];
      column += unsolvedBoard[i][0];
      diagnal1 += unsolvedBoard[i][i];
      diagnal2 += unsolvedBoard[i][2 - i];
    }
    if (rows == 15 && column == 15 && diagnal1 == 15 && diagnal2 == 15) return true;

    return false;
  }

  String boardValueToString(int index, List<List<int>> unsolvedBoard) {
    int row, col;
    (row, col) = indexToRC(index);
    if (unsolvedBoard[row][col] == 0) {
      return "";
    } else {
      return "${unsolvedBoard[row][col]}";
    }
  }

  (int, int) indexToRC(int index) => ((index ~/ 3), (index % 3));

  (List<List<int>>, List<int>) _removeElements(int removeElementsNo, List<List<int>> baseBoard) {
    List<int> removeList = [];
    List<List<int>> unsolvedBoard = baseBoard;
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

    removeList.sort();

    return (unsolvedBoard, removeList);
  }

  (List<List<int>>, List<int>) addElements(
    List<List<int>> board,
    int index,
    int value,
    List<int> removeList,
  ) {
    int r, c;
    (r, c) = indexToRC(index);
    if (board[r][c] != 0) {
      return (board, removeList);
    }
    board[r][c] = value;
    removeList.remove(value);
    removeList.sort();
    return (board, removeList);
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
