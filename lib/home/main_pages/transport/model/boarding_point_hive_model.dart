import 'package:hive/hive.dart';

part 'boarding_point_hive_model.g.dart';

@HiveType(typeId: 26)
class BoardingPointHiveData {
  BoardingPointHiveData({
    this.transportstatus,
    this.fare,
    this.boardingpointname,
    this.busboardingpointid,
  });
  BoardingPointHiveData.fromJson(Map<String, dynamic> json) {
    transportstatus = json['transportstatus'] as String?;
    fare = json['fare'] as String?;
    boardingpointname = json['boardingpointname'] as String?;
    busboardingpointid = json['busboardingpointid'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['transportstatus'] = transportstatus;
    data['fare'] = fare;
    data['boardingpointname'] = boardingpointname;
    data['busboardingpointid'] = busboardingpointid;
    return data;
  }

  static final empty = BoardingPointHiveData(
    transportstatus: '',
    fare: '',
    boardingpointname: 'Boarding point',
    busboardingpointid: '',
  );

  @HiveField(0)
  String? transportstatus;

  @HiveField(1)
  String? fare;

  @HiveField(2)
  String? boardingpointname;

  @HiveField(3)
  String? busboardingpointid;
}
