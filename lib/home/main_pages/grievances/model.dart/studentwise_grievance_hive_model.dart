import 'package:hive/hive.dart';

part 'studentwise_grievance_hive_model.g.dart';

@HiveType(typeId: 12)
class StudentWiseHiveData {
  StudentWiseHiveData({
    this.grievancetime,
    this.grievancecategory,
    this.grievancetype,
    this.grievancesubcategorydesc,
    this.replytext,
    this.subject,
    this.grievanceid,
    this.grievancedesc,
    this.status,
    this.activestatus,
  });

  StudentWiseHiveData.fromJson(Map<String, dynamic> json) {
    grievancetime = json['grievancetime'] as String?;
    grievancecategory = json['grievancecategory'] as String?;
    grievancetype = json['grievancetype'] as String?;
    grievancesubcategorydesc = json['grievancesubcategorydesc'] as String?;
    replytext = json['replytext'] as String?;
    subject = json['subject'] as String?;
    grievanceid = json['grievanceid'] as String?;
    grievancedesc = json['grievancedesc'] as String?;
    status = json['status'] as String?;
    activestatus = json['activestatus'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['grievancetime'] = grievancetime;
    data['grievancecategory'] = grievancecategory;
    data['grievancetype'] = grievancetype;
    data['grievancesubcategorydesc'] = grievancesubcategorydesc;
    data['replytext'] = replytext;
    data['subject'] = subject;
    data['grievanceid'] = grievanceid;
    data['grievancedesc'] = grievancedesc;
    data['status'] = status;
    data['activestatus'] = activestatus;
    return data;
  }

  @HiveField(0)
  String? grievancetime;

  @HiveField(1)
  String? grievancecategory;

  @HiveField(2)
  String? grievancetype;

  @HiveField(3)
  String? grievancesubcategorydesc;

  @HiveField(4)
  String? replytext;

  @HiveField(5)
  String? subject;

  @HiveField(6)
  String? grievanceid;

  @HiveField(7)
  String? grievancedesc;

  @HiveField(8)
  String? status;

  @HiveField(9)
  String? activestatus;
}
