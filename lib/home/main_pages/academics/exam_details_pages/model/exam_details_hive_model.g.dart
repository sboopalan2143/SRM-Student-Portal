// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_details_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExamDetailsHiveDataAdapter extends TypeAdapter<ExamDetailsHiveData> {
  @override
  final int typeId = 1;

  @override
  ExamDetailsHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExamDetailsHiveData(
      result: fields[0] as String?,
      internal: fields[1] as String?,
      external: fields[2] as String?,
      grade: fields[3] as String?,
      semester: fields[4] as String?,
      monthyear: fields[5] as String?,
      marksobtained: fields[6] as String?,
      subjectcode: fields[7] as String?,
      credit: fields[8] as String?,
      subjectdesc: fields[9] as String?,
      attempts: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ExamDetailsHiveData obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.result)
      ..writeByte(1)
      ..write(obj.internal)
      ..writeByte(2)
      ..write(obj.external)
      ..writeByte(3)
      ..write(obj.grade)
      ..writeByte(4)
      ..write(obj.semester)
      ..writeByte(5)
      ..write(obj.monthyear)
      ..writeByte(6)
      ..write(obj.marksobtained)
      ..writeByte(7)
      ..write(obj.subjectcode)
      ..writeByte(8)
      ..write(obj.credit)
      ..writeByte(9)
      ..write(obj.subjectdesc)
      ..writeByte(10)
      ..write(obj.attempts);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExamDetailsHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
