// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectAttendanceHiveDataAdapter
    extends TypeAdapter<SubjectAttendanceHiveData> {
  @override
  final int typeId = 2;

  @override
  SubjectAttendanceHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubjectAttendanceHiveData(
      total: fields[0] as String?,
      presentpercentage: fields[1] as String?,
      absent: fields[2] as String?,
      subjectcode: fields[3] as String?,
      present: fields[4] as String?,
      subjectdesc: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SubjectAttendanceHiveData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.total)
      ..writeByte(1)
      ..write(obj.presentpercentage)
      ..writeByte(2)
      ..write(obj.absent)
      ..writeByte(3)
      ..write(obj.subjectcode)
      ..writeByte(4)
      ..write(obj.present)
      ..writeByte(5)
      ..write(obj.subjectdesc);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectAttendanceHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
