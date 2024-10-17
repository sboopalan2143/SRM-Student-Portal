import 'package:hive/hive.dart';

part 'hourwise_hive_model.g.dart';

@HiveType(typeId: 5)
class HourwiseHiveData {
  HourwiseHiveData({
    this.h1,
    this.h3,
    this.h5,
    this.attendancedate,
    this.h6,
    this.h7,
    this.h2,
  });

  HourwiseHiveData.fromJson(Map<String, dynamic> json) {
    h1 = json['h1'] as String?;
    h3 = json['h3'] as String?;
    h5 = json['h5'] as String?;
    attendancedate = json['attendancedate'] as String?;
    h6 = json['h6'] as String?;
    h7 = json['h7'] as String?;
    h2 = json['h2'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['h1'] = h1;
    data['h3'] = h3;
    data['h5'] = h5;
    data['attendancedate'] = attendancedate;
    data['h6'] = h6;
    data['h7'] = h7;
    data['h2'] = h2;
    return data;
  }

  @HiveField(0)
  String? h1;

  @HiveField(1)
  String? h3;

  @HiveField(2)
  String? h5;

  @HiveField(3)
  String? attendancedate;

  @HiveField(4)
  String? h6;

  @HiveField(5)
  String? h7;

  @HiveField(6)
  String? h2;
}
