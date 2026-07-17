// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'strooptext_bloc.dart';

class StrooptextState extends Equatable {
  final int correctValueIndex;
  final List<int> optionsList;
  final int scoreText;
  final int targetScoreEffect;
  final int targetScoreText;
  final int scoreEffect;
  final int seconds;
  final String text;

  const StrooptextState({
    this.correctValueIndex = 0,
    this.optionsList = const [0, 0, 0, 0],
    this.scoreText = 0,
    this.targetScoreEffect = 0,
    this.targetScoreText = 0,
    this.scoreEffect = 0,
    this.seconds = 60,
    this.text = "",
  });

  @override
  List<Object> get props => [
    correctValueIndex,
    optionsList,
    scoreText,
    scoreEffect,
    targetScoreEffect,
    targetScoreText,
    seconds,
    text,
  ];

  StrooptextState copyWith({
    int? correctValueIndex,
    List<int>? optionsList,
    int? scoreEffect,
    int? scoreText,
    int? targetScoreEffect,
    int? targetScoreText,
    int? seconds,
    String? text,
  }) {
    return StrooptextState(
      correctValueIndex: correctValueIndex ?? this.correctValueIndex,
      optionsList: optionsList ?? this.optionsList,
      scoreEffect: scoreEffect ?? this.scoreEffect,
      scoreText: scoreText ?? this.scoreText,
      targetScoreEffect: targetScoreEffect ?? this.targetScoreEffect,
      targetScoreText: targetScoreText ?? this.targetScoreText,
      seconds: seconds ?? this.seconds,
      text: text ?? this.text,
    );
  }
}
