// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cummulative_attendance_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CumulativeAttendanceHiveDataAdapter
    extends TypeAdapter<CumulativeAttendanceHiveData> {
  @override
  final int typeId = 3;

  @override
  CumulativeAttendanceHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CumulativeAttendanceHiveData(
      attendancemonthyear: fields[0] as String?,
      medical: fields[1] as String?,
      absent: fields[2] as String?,
      present: fields[3] as String?,
      odabsent: fields[4] as String?,
      odpresent: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CumulativeAttendanceHiveData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.attendancemonthyear)
      ..writeByte(1)
      ..write(obj.medical)
      ..writeByte(2)
      ..write(obj.absent)
      ..writeByte(3)
      ..write(obj.present)
      ..writeByte(4)
      ..write(obj.odabsent)
      ..writeByte(5)
      ..write(obj.odpresent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CumulativeAttendanceHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
