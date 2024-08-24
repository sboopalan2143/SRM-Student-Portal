class ProfileResponseModel {
  ProfileResponseModel({this.status, this.message, this.data});

  ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <ProfileDetails>[];
      for (final v in json['Data'] as List<dynamic>) {
        data!.add(ProfileDetails.fromJson(v as Map<String, dynamic>));
      }
    }
  }
  String? status;
  String? message;
  List<ProfileDetails>? data;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Status'] = status;
    data['Message'] = message;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfileDetails {
  ProfileDetails({
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

  ProfileDetails.fromJson(Map<String, dynamic> json) {
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
  String? academicyear;
  String? address;
  String? studentname;
  String? sex;
  String? father;
  String? program;
  String? admitteddate;
  String? sid;
  String? registerno;
  String? mother;
  String? universityname;
  String? dob;
  String? semester;
  String? sectiondesc;
  String? studentphoto;

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

  static final empty = ProfileDetails(
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
}
