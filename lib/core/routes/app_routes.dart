import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games/bloc/sudoku/sudoku_game_bloc.dart';
import 'package:games/screens/home_screen.dart';
import 'package:games/screens/sudoku_screen.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String homeScreen = "/home_screen";
  static const String sudokuScreen = "/sudoku_screen";

  static GoRouter routes = GoRouter(
    initialLocation: homeScreen,
    routes: [
      GoRoute(path: homeScreen, builder: (context, state) => HomeScreen()),
      GoRoute(
        path: sudokuScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => SudokuGameBloc()..add(Refresh()),
          child: SudokuScreen(),
        ),
      ),
    ],
  );
}
