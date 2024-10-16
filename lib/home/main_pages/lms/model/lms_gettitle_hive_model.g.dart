// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lms_gettitle_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LmsGetTitleHiveDataAdapter extends TypeAdapter<LmsGetTitleHiveData> {
  @override
  final int typeId = 25;

  @override
  LmsGetTitleHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LmsGetTitleHiveData(
      classworktypeid: fields[0] as String?,
      classworkid: fields[1] as String?,
      privatecomment: fields[2] as String?,
      enddatetime: fields[3] as String?,
      classworktypedesc: fields[4] as String?,
      classcomment: fields[5] as String?,
      newwork: fields[6] as String?,
      title: fields[7] as String?,
      topicdesc: fields[8] as String?,
      startdatetime: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LmsGetTitleHiveData obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.classworktypeid)
      ..writeByte(1)
      ..write(obj.classworkid)
      ..writeByte(2)
      ..write(obj.privatecomment)
      ..writeByte(3)
      ..write(obj.enddatetime)
      ..writeByte(4)
      ..write(obj.classworktypedesc)
      ..writeByte(5)
      ..write(obj.classcomment)
      ..writeByte(6)
      ..write(obj.newwork)
      ..writeByte(7)
      ..write(obj.title)
      ..writeByte(8)
      ..write(obj.topicdesc)
      ..writeByte(9)
      ..write(obj.startdatetime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LmsGetTitleHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
