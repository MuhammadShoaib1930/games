import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:games/bloc/magic_square/magic_square_bloc.dart';
import 'package:games/logics/magic_square_logic.dart';

class MagicSquareScreen extends StatelessWidget {
  MagicSquareScreen({super.key});
  final MagicSquareLogic magicSquareLogic = MagicSquareLogic();
  @override
  Widget build(BuildContext context) {
    magicSquareLogic.generateBoard(8);
    TextStyle textStyle = TextStyle(fontSize: 18);
    return Scaffold(
      appBar: AppBar(title: Text("Magic Square"), centerTitle: true),
      body: BlocBuilder<MagicSquareBloc, MagicSquareState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsetsGeometry.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Level ${state.level}", style: textStyle)],
                    ),
                  ),
                  SizedBox(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            context.read<MagicSquareBloc>().add(Fill(index: index));
                          },
                          child: Container(
                            decoration: BoxDecoration(border: magicSquareLogic.border(index)),
                            child: Center(
                              child: Text(
                                magicSquareLogic.boardValueToString(index, state.unSolvedBoard),
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                    child: Row(
                      children: List.generate(
                        state.removeList.length,
                        (index) => (state.removeList.isNotEmpty)
                            ? Expanded(
                                child: InkWell(
                                  onTap: () {
                                    context.read<MagicSquareBloc>().add(
                                      SelectValue(value: state.removeList[index]),
                                    );
                                  },
                                  child: Card(
                                    color: (state.value == state.removeList[index])
                                        ? Colors.blue
                                        : Colors.grey[100],
                                    child: Center(
                                      child: Text(
                                        state.removeList[index].toString(),
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ),
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
