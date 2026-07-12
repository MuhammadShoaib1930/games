// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stroop_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StroopModelAdapter extends TypeAdapter<StroopModel> {
  @override
  final int typeId = 3;

  @override
  StroopModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StroopModel(
      stropTextMaxScore: fields[0] as int,
      stropEffectMaxScore: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, StroopModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.stropTextMaxScore)
      ..writeByte(1)
      ..write(obj.stropEffectMaxScore);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StroopModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
