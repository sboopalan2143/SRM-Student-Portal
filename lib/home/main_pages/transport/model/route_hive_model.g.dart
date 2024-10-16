// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RouteDetailsHiveDataAdapter extends TypeAdapter<RouteDetailsHiveData> {
  @override
  final int typeId = 27;

  @override
  RouteDetailsHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RouteDetailsHiveData(
      busrouteid: fields[0] as String?,
      busroutename: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, RouteDetailsHiveData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.busrouteid)
      ..writeByte(1)
      ..write(obj.busroutename);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RouteDetailsHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
