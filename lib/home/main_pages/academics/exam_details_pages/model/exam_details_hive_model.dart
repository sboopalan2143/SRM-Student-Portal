import 'package:hive/hive.dart';

part 'exam_details_hive_model.g.dart';

@HiveType(typeId: 1)
class ExamDetailsHiveData {
  ExamDetailsHiveData({
    this.result,
    this.internal,
    this.external,
    this.grade,
    this.semester,
    this.monthyear,
    this.marksobtained,
    this.subjectcode,
    this.credit,
    this.subjectdesc,
    this.attempts,
  });

  ExamDetailsHiveData.fromJson(Map<String, dynamic> json) {
    result = json['result'] as String?;
    internal = json['internal'] as String?;
    external = json['external'] as String?;
    grade = json['grade'] as String?;
    semester = json['semester'] as String?;
    monthyear = json['monthyear'] as String?;
    marksobtained = json['marksobtained'] as String?;
    subjectcode = json['subjectcode'] as String?;
    credit = json['credit'] as String?;
    subjectdesc = json['subjectdesc'] as String?;
    attempts = json['attempts'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['result'] = result;
    data['internal'] = internal;
    data['external'] = external;
    data['grade'] = grade;
    data['semester'] = semester;
    data['monthyear'] = monthyear;
    data['marksobtained'] = marksobtained;
    data['subjectcode'] = subjectcode;
    data['credit'] = credit;
    data['subjectdesc'] = subjectdesc;
    data['attempts'] = attempts;
    return data;
  }

  static final empty = ExamDetailsHiveData(
    result: '',
    internal: '',
    external: '',
    grade: '',
    semester: '',
    monthyear: '',
    marksobtained: '',
    subjectcode: '',
    credit: '',
    subjectdesc: '',
    attempts: '',
  );

  @HiveField(0)
  String? result;

  @HiveField(1)
  String? internal;

  @HiveField(2)
  String? external;

  @HiveField(3)
  String? grade;

  @HiveField(4)
  String? semester;

  @HiveField(5)
  String? monthyear;

  @HiveField(6)
  String? marksobtained;

  @HiveField(7)
  String? subjectcode;

  @HiveField(8)
  String? credit;

  @HiveField(9)
  String? subjectdesc;

  @HiveField(10)
  String? attempts;
}
