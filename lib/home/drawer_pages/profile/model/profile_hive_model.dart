import 'package:hive/hive.dart';

part 'profile_hive_model.g.dart';

@HiveType(typeId: 0)
class ProfileHiveData {
 ProfileHiveData({
    this.academicyear,
    this.address,
    this.studentname,
    this.sex,
    this.father,
    this.program,
    this.admitteddate,
    this.sid,
    this.registerno,
    this.mother,
    this.universityname,
    this.dob,
    this.semester,
    this.sectiondesc,
    this.studentphoto,
  });

  ProfileHiveData.fromJson(Map<String, dynamic> json) {
    academicyear = json['academicyear'] as String?;
    address = json['address'] as String?;
    studentname = json['studentname'] as String?;
    sex = json['sex'] as String?;
    father = json['father'] as String?;
    program = json['program'] as String?;
    admitteddate = json['admitteddate'] as String?;
    sid = json['sid'] as String?;
    registerno = json['registerno'] as String?;
    mother = json['mother'] as String?;
    universityname = json['universityname'] as String?;
    dob = json['dob'] as String?;
    semester = json['semester'] as String?;
    sectiondesc = json['sectiondesc'] as String?;
    studentphoto = json['studentphoto'] as String?;
  }
 

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['academicyear'] = academicyear;
    data['address'] = address;
    data['studentname'] = studentname;
    data['sex'] = sex;
    data['father'] = father;
    data['program'] = program;
    data['admitteddate'] = admitteddate;
    data['sid'] = sid;
    data['registerno'] = registerno;
    data['mother'] = mother;
    data['universityname'] = universityname;
    data['dob'] = dob;
    data['semester'] = semester;
    data['sectiondesc'] = sectiondesc;
    data['studentphoto'] = studentphoto;
    return data;
  }

  static final empty = ProfileHiveData(
    academicyear: '',
    address: '',
    studentname: '',
    sex: '',
    father: '',
    program: '',
    admitteddate: '',
    sid: '',
    registerno: '',
    mother: '',
    universityname: '',
    dob: '',
    semester: '',
    sectiondesc: '',
    studentphoto: '',
  );
  @HiveField(0)
  String? academicyear;

  @HiveField(1)
  String? address;

  @HiveField(2)
  String? studentname;

  @HiveField(3)
  String? sex;

  @HiveField(4)
  String? father;

  @HiveField(5)
  String? program;

  @HiveField(6)
  String? admitteddate;

  @HiveField(7)
  String? sid;

  @HiveField(8)
  String? registerno;

  @HiveField(9)
  String? mother;

  @HiveField(10)
  String? universityname;

  @HiveField(11)
  String? dob;

  @HiveField(12)
  String? semester;

  @HiveField(13)
  String? sectiondesc;

  @HiveField(14)
  String? studentphoto;
}
