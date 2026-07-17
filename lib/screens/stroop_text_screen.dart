import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:games/bloc/stroop_text/strooptext_bloc.dart';
import 'package:games/logics/stroop_logic.dart';
import 'package:games/services/hive_service.dart';

class StroopTextScreen extends StatelessWidget {
  const StroopTextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<StrooptextBloc, StrooptextState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${state.scoreText} "),
                Text("Target: ${state.targetScoreText} "),
                Text("${state.seconds}"),
              ],
            );
          },
        ),
        centerTitle: true,
      ),

      body: BlocBuilder<StrooptextBloc, StrooptextState>(
        builder: (context, state) {
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 15,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Container(
                      height: 200.h,
                      width: 300.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusGeometry.circular(50.r),

                        color: (HiveService().isDark())
                            ? (state.correctValueIndex == 0)
                                  ? Colors.grey[100]
                                  : Colors.transparent
                            : (state.correctValueIndex == 1)
                            ? Colors.black38
                            : Colors.transparent,
                      ),
                      child: Center(
                        child: Text(
                          "${state.text.toUpperCase()} ",
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: StroopLogic().mainTextColor(state.correctValueIndex),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 300.w,
                  height: 300.w,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemBuilder: (context, index) => Card(
                      child: InkWell(
                        onTap: () => context.read<StrooptextBloc>().add(
                          Solved(userSelected: state.optionsList[index], isText: false),
                        ),
                        child: Center(
                          // heightFactor: 100.r,
                          widthFactor: 100.r,
                          child: Text(
                            StroopLogic.listName[state.optionsList[index]],
                            style: TextStyle(
                              fontSize: 24,
                              color: (HiveService().isDark()) ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    itemCount: state.optionsList.length,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
