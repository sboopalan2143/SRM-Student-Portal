// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalendarHiveModelDataAdapter extends TypeAdapter<CalendarHiveModelData> {
  @override
  final int typeId = 31;

  @override
  CalendarHiveModelData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalendarHiveModelData(
      date: fields[0] as String?,
      daystatus: fields[1] as String?,
      holidaystatus: fields[2] as String?,
      weekdayno: fields[3] as String?,
      semester: fields[4] as String?,
      day: fields[5] as String?,
      remarks: fields[6] as String?,
      dayorder: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CalendarHiveModelData obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.daystatus)
      ..writeByte(2)
      ..write(obj.holidaystatus)
      ..writeByte(3)
      ..write(obj.weekdayno)
      ..writeByte(4)
      ..write(obj.semester)
      ..writeByte(5)
      ..write(obj.day)
      ..writeByte(6)
      ..write(obj.remarks)
      ..writeByte(7)
      ..write(obj.dayorder);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalendarHiveModelDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
