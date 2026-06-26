import 'package:flutter/material.dart';
import 'package:games/core/routes/app_routes.dart';
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
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                context.go(AppRoutes.sudokuScreen);
              },
              child: Text("Sudoku"),
            ),
          ],
        ),
      ),
    );
  }
}
