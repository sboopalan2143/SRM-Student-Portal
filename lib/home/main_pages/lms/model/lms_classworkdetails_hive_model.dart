import 'package:hive/hive.dart';

part 'lms_classworkdetails_hive_model.g.dart';

@HiveType(typeId: 22)
class ClassWorkDetailsHiveData {
  ClassWorkDetailsHiveData({
    this.mcqmarksperquestions,
    this.instructions,
    this.classworktypeid,
    this.cnt,
    this.classworktypedesc,
    this.titleTam,
    this.topicdesc,
    this.mcqminmarktopass,
    this.dpstartdatetime,
    this.mcqtimelimit,
    this.classworkid,
    this.stuimageattachmentid,
    this.fieldrequirement,
    this.topicTam,
    this.classworkreplyid,
    this.remarks,
    this.dpenddatetime,
  });

  ClassWorkDetailsHiveData.fromJson(Map<String, dynamic> json) {
    mcqmarksperquestions = json['mcqmarksperquestions'] as String?;
    instructions = json['instructions'] as String?;
    classworktypeid = json['classworktypeid'] as String?;
    cnt = json['cnt'] as String?;
    classworktypedesc = json['classworktypedesc'] as String?;
    titleTam = json['TitleTam'] as String?;
    topicdesc = json['topicdesc'] as String?;
    mcqminmarktopass = json['mcqminmarktopass'] as String?;
    dpstartdatetime = json['dpstartdatetime'] as String?;
    mcqtimelimit = json['mcqtimelimit'] as String?;
    classworkid = json['classworkid'] as String?;
    stuimageattachmentid = json['stuimageattachmentid'] as String?;
    fieldrequirement = json['fieldrequirement'] as String?;
    topicTam = json['TopicTam'] as String?;
    classworkreplyid = json['classworkreplyid'] as String?;
    remarks = json['remarks'] as String?;
    dpenddatetime = json['dpenddatetime'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['mcqmarksperquestions'] = mcqmarksperquestions;
    data['instructions'] = instructions;
    data['classworktypeid'] = classworktypeid;
    data['cnt'] = cnt;
    data['classworktypedesc'] = classworktypedesc;
    data['TitleTam'] = titleTam;
    data['topicdesc'] = topicdesc;
    data['mcqminmarktopass'] = mcqminmarktopass;
    data['dpstartdatetime'] = dpstartdatetime;
    data['mcqtimelimit'] = mcqtimelimit;
    data['classworkid'] = classworkid;
    data['stuimageattachmentid'] = stuimageattachmentid;
    data['fieldrequirement'] = fieldrequirement;
    data['TopicTam'] = topicTam;
    data['classworkreplyid'] = classworkreplyid;
    data['remarks'] = remarks;
    data['dpenddatetime'] = dpenddatetime;
    return data;
  }

  @HiveField(0)
  String? mcqmarksperquestions;

  @HiveField(1)
  String? instructions;

  @HiveField(2)
  String? classworktypeid;

  @HiveField(3)
  String? cnt;

  @HiveField(4)
  String? classworktypedesc;

  @HiveField(5)
  String? titleTam;

  @HiveField(6)
  String? topicdesc;

  @HiveField(7)
  String? mcqminmarktopass;

  @HiveField(8)
  String? dpstartdatetime;

  @HiveField(9)
  String? mcqtimelimit;

  @HiveField(10)
  String? classworkid;

  @HiveField(11)
  String? stuimageattachmentid;

  @HiveField(12)
  String? fieldrequirement;

  @HiveField(13)
  String? topicTam;

  @HiveField(14)
  String? classworkreplyid;

  @HiveField(15)
  String? remarks;

  @HiveField(16)
  String? dpenddatetime;
}
