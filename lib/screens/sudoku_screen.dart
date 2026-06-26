import 'package:flutter/material.dart';
import 'package:games/logics/sudoku_board.dart';
import 'package:games/logics/sudoku_game.dart';

class SudokuScreen extends StatelessWidget {
  const SudokuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("data")),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(12),
          child: Column(
            children: [
              SizedBox(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 9),
                  itemCount: 81,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(border: SudokuBoard().border(index)),
                        child: Center(
                          child: Text(
                            SudokuGame().boardValueToString(index, SudokuGame().unSolvedBoard),
                            style: TextStyle(
                              fontSize: 22,
                              color: SudokuBoard().textColor(
                                index,
                                SudokuGame().solvedBoard,
                                SudokuGame().unSolvedBoard,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
