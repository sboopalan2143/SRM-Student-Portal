// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'border_point_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BorderPointHiveDataAdapter extends TypeAdapter<BorderPointHiveData> {
  @override
  final int typeId = 26;

  @override
  BorderPointHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BorderPointHiveData(
      transportstatus: fields[0] as String?,
      fare: fields[1] as String?,
      boardingpointname: fields[2] as String?,
      busboardingpointid: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BorderPointHiveData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.transportstatus)
      ..writeByte(1)
      ..write(obj.fare)
      ..writeByte(2)
      ..write(obj.boardingpointname)
      ..writeByte(3)
      ..write(obj.busboardingpointid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BorderPointHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
