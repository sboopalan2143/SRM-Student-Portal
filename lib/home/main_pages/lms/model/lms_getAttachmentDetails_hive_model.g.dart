// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lms_getAttachmentDetails_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetAttachmentDetailsHiveDataAdapter
    extends TypeAdapter<GetAttachmentDetailsHiveData> {
  @override
  final int typeId = 23;

  @override
  GetAttachmentDetailsHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetAttachmentDetailsHiveData(
      filename: fields[0] as String?,
      actualname: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GetAttachmentDetailsHiveData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.filename)
      ..writeByte(1)
      ..write(obj.actualname);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetAttachmentDetailsHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
