// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_responce_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectHiveDataAdapter extends TypeAdapter<SubjectHiveData> {
  @override
  final int typeId = 4;

  @override
  SubjectHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubjectHiveData(
      subjectdetails: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SubjectHiveData obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.subjectdetails);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
