import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:games/bloc/sudoku/sudoku_game_bloc.dart';
import 'package:games/logics/sudoku_board.dart';
import 'package:games/logics/sudoku_game.dart';
import 'package:games/services/hive_service.dart';
import 'package:games/widgets/app_sudoku_dialog.dart';
import 'package:go_router/go_router.dart';

class SudokuScreen extends StatelessWidget {
  final bool isDark = HiveService().getAppSettings().isDark;
  final SudokuGame sudokuGame = SudokuGame();
  SudokuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SudokuBoard"), centerTitle: true),

      body: BlocBuilder<SudokuGameBloc, SudokuGameState>(
        builder: (context, state) {
          if (state.unsolvedBoard.isEmpty) {
            return SizedBox();
          }
          return SafeArea(
            child: Padding(
              padding: EdgeInsetsGeometry.all(2),
              child: Column(
                spacing: 15,
                children: [
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Score: ${state.score}", style: TextStyle(fontSize: 24)),
                          Text("Tries: ${state.tries}", style: TextStyle(fontSize: 24)),
                          Text("Level: ${state.level}", style: TextStyle(fontSize: 24)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 9,
                      ),
                      itemCount: 81,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            if (state.tries <= 0) {
                              showDialog(
                                context: context,
                                builder: (contexts) => AppSudokuDilog(
                                  callBackWatch: () {
                                    Timer(Duration(seconds: 3), () {
                                      context.read<SudokuGameBloc>().add(Tries());
                                      contexts.pop();
                                    });
                                  },
                                  cancel: () {
                                    context.read<SudokuGameBloc>().add(Refresh());
                                    context.pop();
                                  },
                                  level: state.level,
                                  score: state.score,
                                ),
                              );
                            } else {
                              context.read<SudokuGameBloc>().add(SelectIndex(index: index));
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: SudokuBoard().border(index),
                              color: SudokuBoard().selectedColor(
                                index: index,
                                selectedIndex: state.selectedIndex,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                sudokuGame.boardValueToString(index, state.unsolvedBoard),
                                style: TextStyle(
                                  fontSize: 24,
                                  color: SudokuBoard().textColor(
                                    index,
                                    sudokuGame.solvedBoard,
                                    sudokuGame.unSolvedBoard,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    child: Align(
                      alignment: AlignmentGeometry.centerEnd,
                      child: InkWell(
                        onTap: () => context.read<SudokuGameBloc>().add(IsFillByValue()),
                        child: Container(
                          width: 30.w,
                          height: 15.h,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusGeometry.directional(
                              topStart: Radius.circular(20.r),
                              bottomEnd: Radius.circular(20.r),
                              bottomStart: Radius.circular(20.r),
                              topEnd: Radius.circular(20.r),
                            ),
                            color: (state.byValueFill) ? Colors.blue : Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 40.h,
                    child: Row(
                      children: List.generate(
                        9,
                        (index) => Expanded(
                          child: InkWell(
                            onTap: () {
                              if (state.tries <= 0) {
                                showDialog(
                                  context: context,
                                  builder: (contexts) => AppSudokuDilog(
                                    callBackWatch: () {
                                      Timer(Duration(seconds: 5), () {
                                        context.read<SudokuGameBloc>().add(Tries());
                                      });
                                      context.pop();
                                    },
                                    cancel: () {
                                      context.read<SudokuGameBloc>().add(Refresh());
                                      context.pop();
                                    },
                                    level: state.level,
                                    score: state.score,
                                  ),
                                );
                              } else {
                                context.read<SudokuGameBloc>().add(SelectValue(value: index + 1));
                              }
                            },
                            child: Card(
                              color: (state.byValueFill && state.selectedValue == index + 1)
                                  ? Colors.blue
                                  : (isDark)
                                  ? Colors.grey[900]
                                  : Colors.grey[100], 
                              child: Center(
                                child: Text(
                                  (index + 1).toString(),
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () => context.read<SudokuGameBloc>().add(Refresh()),
                          child: Text("Reset"),
                        ),
                        // ElevatedButton(
                        //   onPressed: () => context.read<SudokuGameBloc>().add(Hint()),
                        //   child: Text(
                        //     "Hint",
                        //     style: TextStyle(color: (state.isHint) ? Colors.blue : Colors.black),
                        //   ),
                        // ),
                        ElevatedButton(
                          onPressed: () {
                            if (state.tries <= 0) {
                              showDialog(
                                context: context,
                                builder: (contexts) => AppSudokuDilog(
                                  callBackWatch: () {
                                    Timer(Duration(seconds: 5), () {
                                      context.read<SudokuGameBloc>().add(Tries());
                                    });
                                    context.pop();
                                  },
                                  cancel: () {
                                    context.read<SudokuGameBloc>().add(Refresh());
                                    context.pop();
                                  },
                                  level: state.level,
                                  score: state.score,
                                ),
                              );
                            } else {
                              context.read<SudokuGameBloc>().add(Remove());
                            }
                          },
                          child: Text("Remove"),
                        ),
                        ElevatedButton(onPressed: () => context.pop(), child: Text("Cancel")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
