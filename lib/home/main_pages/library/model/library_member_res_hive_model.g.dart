// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_member_res_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LibraryMemberHiveDataAdapter extends TypeAdapter<LibraryMemberHiveData> {
  @override
  final int typeId = 19;

  @override
  LibraryMemberHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LibraryMemberHiveData(
      membercode: fields[0] as String?,
      membertype: fields[1] as String?,
      policyname: fields[2] as String?,
      membername: fields[3] as String?,
      status: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LibraryMemberHiveData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.membercode)
      ..writeByte(1)
      ..write(obj.membertype)
      ..writeByte(2)
      ..write(obj.policyname)
      ..writeByte(3)
      ..write(obj.membername)
      ..writeByte(4)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LibraryMemberHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
