import 'package:hive/hive.dart';

part 'cummulative_attendance_hive.g.dart';

@HiveType(typeId: 3)
class CumulativeAttendanceHiveData {
  CumulativeAttendanceHiveData({
    this.attendancemonthyear,
    this.medical,
    this.absent,
    this.present,
    this.odabsent,
    this.odpresent,
  });

  CumulativeAttendanceHiveData.fromJson(Map<String, dynamic> json) {
    attendancemonthyear = json['attendancemonthyear'] as String?;
    medical = json['medical'] as String?;
    absent = json['absent'] as String?;
    present = json['present'] as String?;
    odabsent = json['odabsent'] as String?;
    odpresent = json['odpresent'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['attendancemonthyear'] = attendancemonthyear;
    data['medical'] = medical;
    data['absent'] = absent;
    data['present'] = present;
    data['odabsent'] = odabsent;
    data['odpresent'] = odpresent;
    return data;
  }

  static final empty = CumulativeAttendanceHiveData(
    attendancemonthyear: '',
    medical: '',
    absent: '',
    present: '',
    odabsent: '',
    odpresent: '',
  );

  @HiveField(0)
  String? attendancemonthyear;

  @HiveField(1)
  String? medical;

  @HiveField(2)
  String? absent;

  @HiveField(3)
  String? present;

  @HiveField(4)
  String? odabsent;

  @HiveField(5)
  String? odpresent;
}
