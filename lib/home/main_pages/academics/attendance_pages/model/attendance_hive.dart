import 'package:hive/hive.dart';

part 'attendance_hive.g.dart';

@HiveType(typeId: 2)
class SubjectAttendanceHiveData {
  SubjectAttendanceHiveData({
    this.total,
    this.presentpercentage,
    this.absent,
    this.subjectcode,
    this.present,
    this.subjectdesc,
  });

  SubjectAttendanceHiveData.fromJson(Map<String, dynamic> json) {
    total = json['total'] as String?;
    presentpercentage = json['presentpercentage'] as String?;
    absent = json['absent'] as String?;
    subjectcode = json['subjectcode'] as String?;
    present = json['present'] as String?;
    subjectdesc = json['subjectdesc'] as String?;
  }
 

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['total'] = total;
    data['presentpercentage'] = presentpercentage;
    data['absent'] = absent;
    data['subjectcode'] = subjectcode;
    data['present'] = present;
    data['subjectdesc'] = subjectdesc;
    return data;
  }


  @HiveField(0)
  String? total;

  @HiveField(1)
  String? presentpercentage;

  @HiveField(2)
  String? absent;

  @HiveField(3)
  String? subjectcode;

  @HiveField(4)
  String? present;

  @HiveField(5)
  String? subjectdesc;

 
}
