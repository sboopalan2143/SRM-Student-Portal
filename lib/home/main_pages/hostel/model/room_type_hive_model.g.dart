// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_type_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoomTypeHiveDataAdapter extends TypeAdapter<RoomTypeHiveData> {
  @override
  final int typeId = 18;

  @override
  RoomTypeHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RoomTypeHiveData(
      applicationfee: fields[0] as String?,
      messfees: fields[1] as String?,
      roomtypeid: fields[2] as String?,
      cautiondepositfee: fields[3] as String?,
      hostelstatus: fields[4] as String?,
      roomtypename: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, RoomTypeHiveData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.applicationfee)
      ..writeByte(1)
      ..write(obj.messfees)
      ..writeByte(2)
      ..write(obj.roomtypeid)
      ..writeByte(3)
      ..write(obj.cautiondepositfee)
      ..writeByte(4)
      ..write(obj.hostelstatus)
      ..writeByte(5)
      ..write(obj.roomtypename);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoomTypeHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
