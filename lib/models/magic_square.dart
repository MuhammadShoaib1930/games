import 'package:hive/hive.dart';

part 'magic_square.g.dart';

@HiveType(typeId: 2)
class MagicSquare {
  @HiveField(0)
  final int score;
  @HiveField(1)
  final int level;
  MagicSquare({required this.score, required this.level});
  MagicSquare copyWith({int? score, int? level}) {
    return MagicSquare(score: score ?? this.score, level: level ?? this.level);
  }
}
