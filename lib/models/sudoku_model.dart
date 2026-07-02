import 'package:hive/hive.dart';

part 'sudoku_model.g.dart';

@HiveType(typeId: 1)
class SudokuModel {
  @HiveField(0)
  final int score;
  @HiveField(1)
  final int tries;
  @HiveField(2)
  final int level;
  @HiveField(3)
  final int difficulty;
  SudokuModel({
    required this.score,
    required this.tries,
    required this.level,
    required this.difficulty,
  });

  SudokuModel copyWith({int? score, int? tries, int? level, int? difficulty}) {
    return SudokuModel(
      score: score ?? this.score,
      tries: tries ?? this.tries,
      level: level ?? this.level,
      difficulty: difficulty ?? this.difficulty,
    );
  }
}
