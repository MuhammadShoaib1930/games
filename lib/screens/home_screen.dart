import 'package:flutter/material.dart';
import 'package:games/core/routes/app_routes.dart';
import 'package:games/logics/magic_square_logic.dart';
import 'package:games/models/magic_square.dart';
import 'package:games/widgets/app_drawer.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(title: Text("Games")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            spacing: 15,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              ElevatedButton(
                onPressed: () {
                  context.push(AppRoutes.sudokuScreen);
                },
                child: Text("Sudoku"),
              ),
              ElevatedButton(
                onPressed: () {
                  context.push(AppRoutes.magicSquareScreen);
                },
                child: Text("Magic Square"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
