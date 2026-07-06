// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'magic_square_bloc.dart';

class MagicSquareState extends Equatable {
  final int level;
  final int value;
  final List<List<int>> unSolvedBoard;
  final List<int> removeList;
  const MagicSquareState({
    this.level = 1,
    this.value = 0,
    this.removeList = const [],
    this.unSolvedBoard = const [
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0],
    ],
  });

  @override
  List<Object> get props => [removeList, level, unSolvedBoard, value];

  MagicSquareState copyWith({
    int? level,
    List<List<int>>? unSolvedBoard,
    int? value,
    List<int>? removeList,
  }) {
    return MagicSquareState(
      level: level ?? this.level,
      unSolvedBoard: unSolvedBoard ?? this.unSolvedBoard,
      value: value ?? this.value,
      removeList: removeList ?? this.removeList,
    );
  }
}
