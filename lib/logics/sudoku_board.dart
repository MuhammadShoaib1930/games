import 'package:flutter/material.dart';
import 'package:games/logics/sudoku_game.dart';
import 'package:games/models/app_settings.dart';
import 'package:games/services/hive_service.dart';

class SudokuBoard {
  final isDark = HiveService().getDataFormBox<AppSettings>(box: HiveService().settingBox).isDark;
  Color selectedColor({required int index, required int selectedIndex}) {
    if (selectedIndex == -1) {
      return (isDark) ? Colors.white12 : Colors.white;
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
    return (isDark) ? Colors.white12 : Colors.white;
  }

  Color textColor(int index, List<List<int>> solvedBoard, List<List<int>> unSolvedBoard) {
    int row, col;
    (row, col) = SudokuGame().indexToRC(index);
    if (solvedBoard[row][col] == unSolvedBoard[row][col] || unSolvedBoard[row][col] == 0) {
      return (isDark) ? Colors.white : Colors.black;
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

  // Widget hintOrValue(
  //   SudokuGame sudokuGame,
  //   int index,
  //   List<List<int>> unsolvedBoard,
  //   bool isHint,
  //   List<HintData> hintData,
  // ) {
  //   HintData hintValue=HintData(0, 0, "");
  //   for (int i = 0; i < hintData.length; i++) {
  //     int row = sudokuGame.indexToRow(index);
  //     int col = sudokuGame.indexToCol(index);
  //     if (row == hintData[i].row && col == hintData[i].col) {
  //       hintValue = hintData[i];
  //     }
  //   }
  //   return Center(
  //     child: (sudokuGame.isValueOrPossibleValue(isHint, unsolvedBoard, index))
  //         ? Text(
  //             hintValue.data,
  //             style: TextStyle(
  //               fontWeight: FontWeight.w300,
  //               fontSize: (hintValue.data.length < 6)
  //                   ? 18
  //                   : (hintValue.data.length < 12)
  //                   ? 14
  //                   : 10.5,
  //             ),
  //           )
  //         : Text(
  //             sudokuGame.boardValueToString(index, unsolvedBoard),
  //             style: TextStyle(
  //               fontSize: 24,
  //               color: SudokuBoard().textColor(
  //                 index,
  //                 sudokuGame.solvedBoard,
  //                 sudokuGame.unSolvedBoard,
  //               ),
  //             ),
  //           ),
  //   );
  // }
}
