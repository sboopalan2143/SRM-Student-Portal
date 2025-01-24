import 'package:hive/hive.dart';

part 'route_hive_model.g.dart';

@HiveType(typeId: 27)
class RouteDetailsHiveData {
  RouteDetailsHiveData({this.busrouteid, this.busroutename});

  RouteDetailsHiveData.fromJson(Map<String, dynamic> json) {
    busrouteid = json['busrouteid'] as String?;
    busroutename = json['busroutename'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['busrouteid'] = busrouteid;
    data['busroutename'] = busroutename;
    return data;
  }

  static final empty = RouteDetailsHiveData(
    busrouteid: '',
    busroutename: 'Route Data',
  );

  @HiveField(0)
  String? busrouteid;

  @HiveField(1)
  String? busroutename;
}
