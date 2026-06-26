import 'package:hive/hive.dart';

part 'sudoku_model.g.dart';

@HiveType(typeId: 1)
class SudokuModel {
  @HiveField(0)
  final String userName;
  @HiveField(1)
  final List<int> score;
  @HiveField(2)
  final List<String> time;
  @HiveField(3)
  final int lost;
  SudokuModel({
    required this.userName,
    required this.score,
    required this.time,
    required this.lost,
  });

  SudokuModel copyWith({
    String? userName,
    List<int>? score,
    List<String>? time,
    int? lost,
  }) {
    return SudokuModel(
      userName: userName ?? this.userName,
      score: score ?? this.score,
      time: time ?? this.time,
      lost: lost ?? this.lost,
    );
  }
}
