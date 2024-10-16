// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lms_getSubject_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LmsSubjectHiveDataAdapter extends TypeAdapter<LmsSubjectHiveData> {
  @override
  final int typeId = 24;

  @override
  LmsSubjectHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LmsSubjectHiveData(
      staffname: fields[0] as String?,
      subjectcode: fields[1] as String?,
      subjectid: fields[2] as String?,
      subjectdesc: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LmsSubjectHiveData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.staffname)
      ..writeByte(1)
      ..write(obj.subjectcode)
      ..writeByte(2)
      ..write(obj.subjectid)
      ..writeByte(3)
      ..write(obj.subjectdesc);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LmsSubjectHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
