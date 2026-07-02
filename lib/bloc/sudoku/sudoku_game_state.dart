part of 'sudoku_game_bloc.dart';

class SudokuGameState extends Equatable {
  final List<List<int>> unsolvedBoard;
  final int score;
  final int level;
  final bool byValueFill;
  final int selectedValue;
  final int selectedIndex;
  final int difficulty;
  final int tries;
  // final bool isHint;
  // final List<HintData> hintData;
  const SudokuGameState({
    this.unsolvedBoard = const [],
     this.score= 0,
     this.level=1,
     this.byValueFill=false,
     this.selectedValue=0,
     this.selectedIndex=-1,
     this.difficulty=10,
     this.tries=3,
    // required this.hintData,
    // required this.isHint,
  });

  @override
  List<Object> get props => [
    unsolvedBoard,
    score,
    level,
    byValueFill,
    selectedValue,
    selectedIndex,
    difficulty,
    tries,
    // hintData,
    // isHint,
  ];

  SudokuGameState copyWith({
    List<List<int>>? unsolvedBoard,
    int? score,
    int? level,
    bool? byValueFill,
    int? selectedValue,
    int? selectedIndex,
    int? difficulty,
    int? tries,
    // List<HintData>? hintData,
    // bool? isHint,
  }) {
    return SudokuGameState(
      unsolvedBoard: unsolvedBoard ?? this.unsolvedBoard,
      score: score ?? this.score,
      level: level ?? this.level,
      byValueFill: byValueFill ?? this.byValueFill,
      selectedValue: selectedValue ?? this.selectedValue,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      difficulty: difficulty ?? this.difficulty,
      tries: tries ?? this.tries,
      // hintData: hintData ?? this.hintData,
      // isHint: isHint ?? this.isHint,
    );
  }
}
