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
              children: [Text("${state.scoreText} "), Text("Target: ${state.targetScoreText}")],
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
                Text("second", style: TextStyle(fontSize: 18)),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusGeometry.circular(50.r),
                      color: (HiveService().isDark())
                          ? Colors.grey
                          : (state.correctValueIndex == 1)
                          ? Colors.grey
                          : Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        StroopLogic().mainTextName(state.optionsList),
                        style: TextStyle(
                          fontSize: 88,
                          fontWeight: FontWeight.bold,
                          color: StroopLogic().mainTextColor(state.correctValueIndex),
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
                          Solved(userSelected: state.optionsList[index], isText: true),
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
