import 'dart:math';

// class HintData {
//   final String data;
//   final int row;
//   final int col;
//   const HintData(this.row, this.col, this.data);
// }

class SudokuGame {
  SudokuGame._internal();
  static final SudokuGame instanc = SudokuGame._internal();
  factory SudokuGame() => instanc;
  List<List<int>> solvedBoard = [];
  List<List<int>> unSolvedBoard = [];
  // List<HintData> hintData = [];
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

  void sudokuGenerate(int removeElementsNo) {
    _mixin(baseBoard);
    _removeElements(removeElementsNo);
  }

  (int, int) indexToRC(int index) => ((index ~/ 9), (index % 9));

  // void hint(List<List<int>> unsolvedBoard) {
  //   for (int i = 0; i < 9; i++) {
  //     for (int j = 0; j < 9; j++) {
  //       if (unsolvedBoard[i][j] == 0) {
  //         hintData.add(HintData(i, j, isPossible(i, j, unsolvedBoard)));
  //       }
  //     }
  //   }
  // }

  // String isPossible(int row, int col, List<List<int>> board) {
  //   List<bool> used = List.filled(10, false);

  //   // Check row
  //   for (int c = 0; c < 9; c++) {
  //     int value = board[row][c];
  //     if (value != 0) {
  //       used[value] = true;
  //     }
  //   }

  //   // Check column
  //   for (int r = 0; r < 9; r++) {
  //     int value = board[r][col];
  //     if (value != 0) {
  //       used[value] = true;
  //     }
  //   }

  //   // Check 3×3 box
  //   int startRow = (row ~/ 3) * 3;
  //   int startCol = (col ~/ 3) * 3;

  //   for (int r = startRow; r < startRow + 3; r++) {
  //     for (int c = startCol; c < startCol + 3; c++) {
  //       int value = board[r][c];
  //       if (value != 0) {
  //         used[value] = true;
  //       }
  //     }
  //   }

  //   String possible = "";

  //   for (int i = 1; i <= 9; i++) {
  //     if (!used[i]) {
  //       if (possible.length - 1 == i) {
  //         possible += i.toString();
  //       } else {
  //         possible += "$i ";
  //       }
  //     }
  //   }

  //   return possible;
  // }

  (bool, int) addData(int index, int value) {
    int row, col;
    (row, col) = indexToRC(index);
    if (index != -1 && value != 0 && unSolvedBoard[row][col] != solvedBoard[row][col]) {
      unSolvedBoard[row][col] = value;
      if (unSolvedBoard[row][col] == solvedBoard[row][col]) {
        return (true, 10);
      } else {
        return (false, 0);
      }
    } else {
      return (true, 0);
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

  List<List<int>> remove(int index, List<List<int>> board) {
    int row, col;
    (row, col) = indexToRC(index);
    if (board[row][col] != solvedBoard[row][col]) {
      board[row][col] = 0;
    }
    return board;
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
    int row, col;
    (row, col) = indexToRC(index);
    if (board[row][col] == 0) {
      return "";
    } else {
      return "${board[row][col]}";
    }
  }

  // void printF() {
  //   SudokuGame sudokuGame = SudokuGame();
  //   sudokuGame.sudokuGenerate(2);
  //   if (sudokuGame.solvedBoard == sudokuGame.unSolvedBoard) {
  //     return;
  //   }
  //   for (int i = 0; i < 9; i++) {
  //     String result = "";
  //     for (int j = 0; j < 9; j++) {
  //       result += "${sudokuGame.solvedBoard[i][j]} ";
  //     }
  //     result += "\t\t";
  //     for (int j = 0; j < 9; j++) {
  //       result += "${sudokuGame.unSolvedBoard[i][j]} ";
  //     }
  //     print(result);
  //   }
  // }

  void _removeElements(int removeElementsNo) {
    removeElementsNo = (removeElementsNo >= 80) ? 80 : removeElementsNo;
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

  // bool isValueOrPossibleValue(bool isHint, List<List<int>> unsolvedBoard, int index) {
  //   return (isHint && unsolvedBoard[indexToRow(index)][indexToCol(index)] == 0);
  // }
}
