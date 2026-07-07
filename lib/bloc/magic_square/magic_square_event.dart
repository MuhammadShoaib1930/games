part of 'magic_square_bloc.dart';

sealed class MagicSquareEvent extends Equatable {
  const MagicSquareEvent();

  @override
  List<Object> get props => [];
}

final class SelectValue extends MagicSquareEvent {
  final int value;
  const SelectValue({required this.value});
  @override
  List<Object> get props => [value];
}

final class Fill extends MagicSquareEvent {
  final int index;
  const Fill({required this.index});
  @override
  List<Object> get props => [index];
}

final class Inital extends MagicSquareEvent {}

final class Remove extends MagicSquareEvent {}
