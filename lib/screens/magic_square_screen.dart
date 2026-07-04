import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:games/logics/magic_square_logic.dart';

class MagicSquareScreen extends StatelessWidget {
  MagicSquareScreen({super.key});
  final MagicSquareLogic magicSquareLogic = MagicSquareLogic();
  @override
  Widget build(BuildContext context) {
    magicSquareLogic.generateBoard(8);
    return Scaffold(
      appBar: AppBar(title: Text("Magic Square"), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(border: MagicSquareLogic().border(index)),
                        child: Center(
                          child: Text(index.toString(), style: TextStyle(fontSize: 24)),
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
                    magicSquareLogic.removeList.length,
                    (index) => Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Card(
                          // color: (state.byValueFill && state.selectedValue == index + 1)
                          //     ? Colors.blue
                          //     : (isDark)
                          //     ? Colors.grey[900]
                          //     : Colors.grey[100],
                          child: Center(
                            child: Text(
                              magicSquareLogic.removeList[index].toString(),
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
