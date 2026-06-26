import 'dart:math';

class SudokuGame {
  SudokuGame._internal();
  static final SudokuGame instanc = SudokuGame._internal();
  factory SudokuGame() => instanc;
  List<List<int>> solvedBoard = [];
  List<List<int>> unSolvedBoard = [];
  void sudokuGenerate(int removeElementsNo) {
    List<List<int>> baseBoard = [
      [1, 2, 3, 4, 5, 6, 7, 8, 9],
      [4, 5, 6, 7, 8, 9, 1, 2, 3],
      [7, 8, 9, 1, 2, 3, 4, 5, 6],

      [2, 3, 4, 5, 6, 7, 8, 9, 1],
      [5, 6, 7, 8, 9, 1, 2, 3, 4],
      [8, 9, 1, 2, 3, 4, 5, 6, 7],

      [3, 4, 5, 6, 7, 8, 9, 1, 2],
      [6, 7, 8, 9, 1, 2, 3, 4, 5],
      [9, 1, 2, 3, 4, 5, 6, 7, 8],
    ];
    _mixin(baseBoard);
    _removeElements(removeElementsNo);
  }

  int indexToRow(int index) {
    return index ~/ 9;
  }

  int indexToCol(int index) {
    return index % 9;
  }

  void addData(int index, int value) {
    int row = indexToRow(index), col = indexToCol(index);
    if (unSolvedBoard[row][col] != solvedBoard[row][col]) {
      unSolvedBoard[row][col] = value;
    }
  }

  bool solved() {
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (unSolvedBoard[i][j] != solvedBoard[i][j]) {
          return false;
        }
      }
    }
    return true;
  }

  void remove(int index) {
    int row = indexToRow(index), col = indexToCol(index);
    if (unSolvedBoard[row][col] != solvedBoard[row][col]) {
      unSolvedBoard[row][col] = 0;
    }
  }

  List<List<int>> copyBoard(List<List<int>> board) {
    return board.map((row) => List<int>.from(row)).toList();
  }

  void _mixin(List<List<int>> result) {
    int r1 = 0;
    int r2 = 0;
    while (r1 == r2) {
      r1 = Random().nextInt(3) * 3;
      r2 = Random().nextInt(3) * 3;
    }
    int end = r1 + 3;
    while (r1 < end) {
      List<int> temp = result[r1];
      result[r1] = result[r2];
      result[r2] = temp;
      r1++;
      r2++;
    }

    int c1 = 0;
    int c2 = 0;
    while (c1 == c2) {
      c1 = Random().nextInt(3) * 3;
      c2 = Random().nextInt(3) * 3;
    }
    for (var i = 0; i < result.length; i++) {
      int temp = result[i][c1];
      result[i][c1] = result[i][c2];
      result[i][c2] = temp;
    }
    unSolvedBoard.clear();
    solvedBoard.clear();
    unSolvedBoard = copyBoard(result);
    solvedBoard = copyBoard(result);
  }

  String boardValueToString(int index, List<List<int>> board) {
    int row = indexToRow(index);
    int col = indexToCol(index);
    if (board[row][col] == 0) {
      return "";
    } else {
      return "${board[row][col]}";
    }
  }

  void printF() {
    SudokuGame sudokuGame = SudokuGame();
    sudokuGame.sudokuGenerate(2);
    if (sudokuGame.solvedBoard == sudokuGame.unSolvedBoard) {
      return;
    }
    for (int i = 0; i < 9; i++) {
      String result = "";
      for (int j = 0; j < 9; j++) {
        result += "${sudokuGame.solvedBoard[i][j]} ";
      }
      result += "\t\t";
      for (int j = 0; j < 9; j++) {
        result += "${sudokuGame.unSolvedBoard[i][j]} ";
      }
      print(result);
    }
  }

  void _removeElements(int removeElementsNo) {
    Random random = Random();
    while (removeElementsNo > 0) {
      int r = random.nextInt(9);
      int c = random.nextInt(9);
      if (unSolvedBoard[r][c] != 0) {
        unSolvedBoard[r][c] = 0;
        removeElementsNo--;
      }
    }
  }
}
