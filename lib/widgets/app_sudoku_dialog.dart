import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSudokuDilog extends StatelessWidget {
  final Function callBackWatch;
  final Function cancel;
  final int score;
  final int level;


  const AppSudokuDilog({super.key, required this.callBackWatch, required this.cancel,required this.level,required this.score});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Dialog(
        constraints: BoxConstraints(maxWidth: 250.w, maxHeight: 150.h, minWidth: 250),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Score: $score", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text("Level: $level", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: () => callBackWatch(), child: Text("Watch Ad.")),
                  ElevatedButton(onPressed: () => cancel(), child: Text("Restart.")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
