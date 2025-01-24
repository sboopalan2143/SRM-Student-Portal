import 'package:hive/hive.dart';

part 'subject_responce_hive_model.g.dart';

@HiveType(typeId: 4)
class SubjectHiveData {
  SubjectHiveData({
    this.subjectdetails,
  });

  SubjectHiveData.fromJson(Map<String, dynamic> json) {
    subjectdetails = json['subjectdetails'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['subjectdetails'] = subjectdetails;
    return data;
  }

  static final empty = SubjectHiveData(
    subjectdetails: '',
  );
  @HiveField(0)
  String? subjectdetails;
}
