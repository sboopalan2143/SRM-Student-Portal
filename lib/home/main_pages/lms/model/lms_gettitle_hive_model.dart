import 'package:hive/hive.dart';

part 'lms_gettitle_hive_model.g.dart';

@HiveType(typeId: 25)
class LmsGetTitleHiveData {
  LmsGetTitleHiveData({
    this.classworktypeid,
    this.classworkid,
    this.privatecomment,
    this.enddatetime,
    this.classworktypedesc,
    this.classcomment,
    this.newwork,
    this.title,
    this.topicdesc,
    this.startdatetime,
  });

  LmsGetTitleHiveData.fromJson(Map<String, dynamic> json) {
    classworktypeid = json['classworktypeid'] as String?;
    classworkid = json['classworkid'] as String?;
    privatecomment = json['privatecomment'] as String?;
    enddatetime = json['enddatetime'] as String?;
    classworktypedesc = json['classworktypedesc'] as String?;
    classcomment = json['classcomment'] as String?;
    newwork = json['newwork'] as String?;
    title = json['title'] as String?;
    topicdesc = json['topicdesc'] as String?;
    startdatetime = json['startdatetime'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['classworktypeid'] = classworktypeid;
    data['classworkid'] = classworkid;
    data['privatecomment'] = privatecomment;
    data['enddatetime'] = enddatetime;
    data['classworktypedesc'] = classworktypedesc;
    data['classcomment'] = classcomment;
    data['newwork'] = newwork;
    data['title'] = title;
    data['topicdesc'] = topicdesc;
    data['startdatetime'] = startdatetime;
    return data;
  }

  @HiveField(0)
  String? classworktypeid;

  @HiveField(1)
  String? classworkid;

  @HiveField(2)
  String? privatecomment;

  @HiveField(3)
  String? enddatetime;

  @HiveField(4)
  String? classworktypedesc;

  @HiveField(5)
  String? classcomment;

  @HiveField(6)
  String? newwork;

  @HiveField(7)
  String? title;

  @HiveField(8)
  String? topicdesc;

  @HiveField(9)
  String? startdatetime;
}
