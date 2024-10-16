import 'package:hive/hive.dart';

part 'lms_getSubject_hive_model.g.dart';

@HiveType(typeId: 24)
class LmsSubjectHiveData {
  LmsSubjectHiveData({
    this.staffname,
    this.subjectcode,
    this.subjectid,
    this.subjectdesc,
  });

  LmsSubjectHiveData.fromJson(Map<String, dynamic> json) {
    staffname = json['staffname'] as String?;
    subjectcode = json['subjectcode'] as String?;
    subjectid = json['subjectid'] as String?;
    subjectdesc = json['subjectdesc'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['staffname'] = staffname;
    data['subjectcode'] = subjectcode;
    data['subjectid'] = subjectid;
    data['subjectdesc'] = subjectdesc;
    return data;
  }

  @HiveField(0)
  String? staffname;

  @HiveField(1)
  String? subjectcode;

  @HiveField(2)
  String? subjectid;

  @HiveField(3)
  String? subjectdesc;
}
