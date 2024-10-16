// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'studentwise_grievance_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentWiseHiveDataAdapter extends TypeAdapter<StudentWiseHiveData> {
  @override
  final int typeId = 12;

  @override
  StudentWiseHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentWiseHiveData(
      grievancetime: fields[0] as String?,
      grievancecategory: fields[1] as String?,
      grievancetype: fields[2] as String?,
      grievancesubcategorydesc: fields[3] as String?,
      replytext: fields[4] as String?,
      subject: fields[5] as String?,
      grievanceid: fields[6] as String?,
      grievancedesc: fields[7] as String?,
      status: fields[8] as String?,
      activestatus: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, StudentWiseHiveData obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.grievancetime)
      ..writeByte(1)
      ..write(obj.grievancecategory)
      ..writeByte(2)
      ..write(obj.grievancetype)
      ..writeByte(3)
      ..write(obj.grievancesubcategorydesc)
      ..writeByte(4)
      ..write(obj.replytext)
      ..writeByte(5)
      ..write(obj.subject)
      ..writeByte(6)
      ..write(obj.grievanceid)
      ..writeByte(7)
      ..write(obj.grievancedesc)
      ..writeByte(8)
      ..write(obj.status)
      ..writeByte(9)
      ..write(obj.activestatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentWiseHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
