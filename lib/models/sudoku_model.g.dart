// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sudoku_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SudokuModelAdapter extends TypeAdapter<SudokuModel> {
  @override
  final int typeId = 1;

  @override
  SudokuModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SudokuModel(
      score: fields[0] as int,
      tries: fields[1] as int,
      level: fields[2] as int,
      difficulty: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SudokuModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.score)
      ..writeByte(1)
      ..write(obj.tries)
      ..writeByte(2)
      ..write(obj.level)
      ..writeByte(3)
      ..write(obj.difficulty);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SudokuModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
