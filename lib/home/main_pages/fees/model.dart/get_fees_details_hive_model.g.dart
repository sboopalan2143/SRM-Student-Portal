// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_fees_details_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetFeesHiveDataAdapter extends TypeAdapter<GetFeesHiveData> {
  @override
  final int typeId = 8;

  @override
  GetFeesHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetFeesHiveData(
      duedate: fields[0] as String?,
      duename: fields[1] as String?,
      dueamount: fields[2] as String?,
      duedescription: fields[3] as String?,
      amtcollected: fields[4] as String?,
      currentdue: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GetFeesHiveData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.duedate)
      ..writeByte(1)
      ..write(obj.duename)
      ..writeByte(2)
      ..write(obj.dueamount)
      ..writeByte(3)
      ..write(obj.duedescription)
      ..writeByte(4)
      ..write(obj.amtcollected)
      ..writeByte(5)
      ..write(obj.currentdue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetFeesHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
