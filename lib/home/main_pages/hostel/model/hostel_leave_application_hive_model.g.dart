// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hostel_leave_application_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HostelLeaveHiveDataAdapter extends TypeAdapter<HostelLeaveHiveData> {
  @override
  final int typeId = 17;

  @override
  HostelLeaveHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HostelLeaveHiveData(
      leavetodate: fields[0] as String?,
      reason: fields[1] as String?,
      leavefromdate: fields[2] as String?,
      status: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HostelLeaveHiveData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.leavetodate)
      ..writeByte(1)
      ..write(obj.reason)
      ..writeByte(2)
      ..write(obj.leavefromdate)
      ..writeByte(3)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HostelLeaveHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
