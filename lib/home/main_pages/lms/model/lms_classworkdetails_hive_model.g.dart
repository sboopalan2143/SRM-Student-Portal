// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lms_classworkdetails_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClassWorkDetailsHiveDataAdapter
    extends TypeAdapter<ClassWorkDetailsHiveData> {
  @override
  final int typeId = 22;

  @override
  ClassWorkDetailsHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClassWorkDetailsHiveData(
      mcqmarksperquestions: fields[0] as String?,
      instructions: fields[1] as String?,
      classworktypeid: fields[2] as String?,
      cnt: fields[3] as String?,
      classworktypedesc: fields[4] as String?,
      titleTam: fields[5] as String?,
      topicdesc: fields[6] as String?,
      mcqminmarktopass: fields[7] as String?,
      dpstartdatetime: fields[8] as String?,
      mcqtimelimit: fields[9] as String?,
      classworkid: fields[10] as String?,
      stuimageattachmentid: fields[11] as String?,
      fieldrequirement: fields[12] as String?,
      topicTam: fields[13] as String?,
      classworkreplyid: fields[14] as String?,
      remarks: fields[15] as String?,
      dpenddatetime: fields[16] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ClassWorkDetailsHiveData obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.mcqmarksperquestions)
      ..writeByte(1)
      ..write(obj.instructions)
      ..writeByte(2)
      ..write(obj.classworktypeid)
      ..writeByte(3)
      ..write(obj.cnt)
      ..writeByte(4)
      ..write(obj.classworktypedesc)
      ..writeByte(5)
      ..write(obj.titleTam)
      ..writeByte(6)
      ..write(obj.topicdesc)
      ..writeByte(7)
      ..write(obj.mcqminmarktopass)
      ..writeByte(8)
      ..write(obj.dpstartdatetime)
      ..writeByte(9)
      ..write(obj.mcqtimelimit)
      ..writeByte(10)
      ..write(obj.classworkid)
      ..writeByte(11)
      ..write(obj.stuimageattachmentid)
      ..writeByte(12)
      ..write(obj.fieldrequirement)
      ..writeByte(13)
      ..write(obj.topicTam)
      ..writeByte(14)
      ..write(obj.classworkreplyid)
      ..writeByte(15)
      ..write(obj.remarks)
      ..writeByte(16)
      ..write(obj.dpenddatetime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClassWorkDetailsHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
