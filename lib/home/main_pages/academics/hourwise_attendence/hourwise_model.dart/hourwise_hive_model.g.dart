// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hourwise_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HourwiseHiveDataAdapter extends TypeAdapter<HourwiseHiveData> {
  @override
  final int typeId = 5;

  @override
  HourwiseHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HourwiseHiveData(
      h1: fields[0] as String?,
      h3: fields[1] as String?,
      h5: fields[2] as String?,
      attendancedate: fields[3] as String?,
      h6: fields[4] as String?,
      h7: fields[5] as String?,
      h2: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HourwiseHiveData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.h1)
      ..writeByte(1)
      ..write(obj.h3)
      ..writeByte(2)
      ..write(obj.h5)
      ..writeByte(3)
      ..write(obj.attendancedate)
      ..writeByte(4)
      ..write(obj.h6)
      ..writeByte(5)
      ..write(obj.h7)
      ..writeByte(6)
      ..write(obj.h2);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HourwiseHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
