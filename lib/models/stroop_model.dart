import 'package:hive_flutter/hive_flutter.dart';

part 'stroop_model.g.dart';

@HiveType(typeId: 3)
class StroopModel {
  @HiveField(0)
  final int stropTextMaxScore;
  @HiveField(1)
  final int stropEffectMaxScore;
  StroopModel({required this.stropTextMaxScore, required this.stropEffectMaxScore});

  StroopModel copyWith({int? stropTextMaxScore, int? stropEffectMaxScore}) {
    return StroopModel(
      stropTextMaxScore: stropTextMaxScore ?? this.stropTextMaxScore,
      stropEffectMaxScore: stropEffectMaxScore ?? this.stropEffectMaxScore,
    );
  }
}
