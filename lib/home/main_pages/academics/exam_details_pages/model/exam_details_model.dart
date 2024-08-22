class ExamDetails {
  String? status;
  String? message;
  List<ExamDetailsData>? data;

  ExamDetails({this.status, this.message, this.data});

  ExamDetails.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <ExamDetailsData>[];
      json['Data'].forEach((v) {
        data!.add(new ExamDetailsData.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExamDetailsData {
  String? result;
  String? internal;
  String? external;
  String? grade;
  String? semester;
  String? monthyear;
  String? marksobtained;
  String? subjectcode;
  String? credit;
  String? subjectdesc;
  String? attempts;

  ExamDetailsData(
      {this.result,
      this.internal,
      this.external,
      this.grade,
      this.semester,
      this.monthyear,
      this.marksobtained,
      this.subjectcode,
      this.credit,
      this.subjectdesc,
      this.attempts});

  ExamDetailsData.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['internal'] = this.internal;
    data['external'] = this.external;
    data['grade'] = this.grade;
    data['semester'] = this.semester;
    data['monthyear'] = this.monthyear;
    data['marksobtained'] = this.marksobtained;
    data['subjectcode'] = this.subjectcode;
    data['credit'] = this.credit;
    data['subjectdesc'] = this.subjectdesc;
    data['attempts'] = this.attempts;
    return data;
  }
}
