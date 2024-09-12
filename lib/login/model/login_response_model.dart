class LoginResponseModel {
  LoginResponseModel({this.status, this.message, this.data});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <LoginData>[];
      for (final v in json['Data'] as List<dynamic>) {
        data!.add(LoginData.fromJson(v as Map<String, dynamic>));
      }
    }
  }
  String? status;
  String? message;
  List<LoginData>? data;

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

class LoginData {
  LoginData({
    this.semesterid,
    this.officename,
    this.officeid,
    this.studentname,
    this.program,
    this.courseid,
    this.sid,
    this.registerno,
  });

  LoginData.fromJson(Map<String, dynamic> json) {
    semesterid = json['semesterid'] as String?;
    officename = json['officename'] as String?;
    officeid = json['officeid'] as int?;
    studentname = json['studentname'] as String?;
    program = json['program'] as String?;
    courseid = json['courseid'] as String?;
    sid = json['sid'] as String?;
    registerno = json['registerno'] as String?;
  }
  String? semesterid;
  String? officename;
  int? officeid;
  String? studentname;
  String? program;
  String? courseid;
  String? sid;
  String? registerno;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['semesterid'] = semesterid;
    data['officename'] = officename;
    data['officeid'] = officeid;
    data['studentname'] = studentname;
    data['program'] = program;
    data['courseid'] = courseid;
    data['sid'] = sid;
    data['registerno'] = registerno;
    return data;
  }

  static final empty = LoginData(
    semesterid: '',
    officename: '',
    studentname: '',
    program: '',
    courseid: '',
    sid: '',
    registerno: '',
  );
}
