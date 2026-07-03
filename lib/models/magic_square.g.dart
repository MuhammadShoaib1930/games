// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'magic_square.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MagicSquareAdapter extends TypeAdapter<MagicSquare> {
  @override
  final int typeId = 2;

  @override
  MagicSquare read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MagicSquare(
      score: fields[0] as int,
      level: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MagicSquare obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.score)
      ..writeByte(1)
      ..write(obj.level);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MagicSquareAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
