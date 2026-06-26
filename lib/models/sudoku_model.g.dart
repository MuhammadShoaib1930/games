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
      userName: fields[0] as String,
      score: (fields[1] as List).cast<int>(),
      time: (fields[2] as List).cast<String>(),
      lost: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SudokuModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userName)
      ..writeByte(1)
      ..write(obj.score)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.lost);
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
