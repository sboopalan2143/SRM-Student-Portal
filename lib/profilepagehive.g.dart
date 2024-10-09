// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profilepagehive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class profilepagehiveAdapter extends TypeAdapter<profilepagehive> {
  @override
  final int typeId = 1;

  @override
  profilepagehive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return profilepagehive(
      academicyear: fields[0] as String?,
      address: fields[1] as String?,
      studentname: fields[2] as String?,
      sex: fields[3] as String?,
      father: fields[4] as String?,
      program: fields[5] as String?,
      admitteddate: fields[6] as String?,
      sid: fields[7] as String?,
      registerno: fields[8] as String?,
      mother: fields[9] as String?,
      universityname: fields[10] as String?,
      dob: fields[11] as String?,
      semester: fields[12] as String?,
      sectiondesc: fields[13] as String?,
      studentphoto: fields[14] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, profilepagehive obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.academicyear)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.studentname)
      ..writeByte(3)
      ..write(obj.sex)
      ..writeByte(4)
      ..write(obj.father)
      ..writeByte(5)
      ..write(obj.program)
      ..writeByte(6)
      ..write(obj.admitteddate)
      ..writeByte(7)
      ..write(obj.sid)
      ..writeByte(8)
      ..write(obj.registerno)
      ..writeByte(9)
      ..write(obj.mother)
      ..writeByte(10)
      ..write(obj.universityname)
      ..writeByte(11)
      ..write(obj.dob)
      ..writeByte(12)
      ..write(obj.semester)
      ..writeByte(13)
      ..write(obj.sectiondesc)
      ..writeByte(14)
      ..write(obj.studentphoto);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is profilepagehiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
