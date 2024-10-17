import 'package:hive/hive.dart';

part 'internal_mark_hive_model.g.dart';

@HiveType(typeId: 6)
class InternalMarkHiveData {
  InternalMarkHiveData({
    this.sumofmarks,
    this.subjectcode,
    this.sumofmaxmarks,
    this.subjectdesc,
  });

  InternalMarkHiveData.fromJson(Map<String, dynamic> json) {
    sumofmarks = json['sumofmarks'] as String?;
    subjectcode = json['subjectcode'] as String?;
    sumofmaxmarks = json['sumofmaxmarks'] as String?;
    subjectdesc = json['subjectdesc'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['sumofmarks'] = sumofmarks;
    data['subjectcode'] = subjectcode;
    data['sumofmaxmarks'] = sumofmaxmarks;
    data['subjectdesc'] = subjectdesc;
    return data;
  }

  @HiveField(0)
  String? sumofmarks;

  @HiveField(1)
  String? subjectcode;

  @HiveField(2)
  String? sumofmaxmarks;

  @HiveField(3)
  String? subjectdesc;
}
