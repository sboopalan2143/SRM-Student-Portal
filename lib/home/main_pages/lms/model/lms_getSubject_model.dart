class GetSubjectModel {
  GetSubjectModel({this.status, this.message, this.data});

  GetSubjectModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <LmsSubjectData>[];
      for (final v in json['Data'] as List<dynamic>) {
        data!.add(LmsSubjectData.fromJson(v as Map<String, dynamic>));
      }
      
    }
  }
  String? status;
  String? message;
  List<LmsSubjectData>? data;

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

class LmsSubjectData {
  LmsSubjectData(
      {this.staffname, this.subjectcode, this.subjectid, this.subjectdesc,});

  LmsSubjectData.fromJson(Map<String, dynamic> json) {
    staffname = json['staffname'] as String?;
    subjectcode = json['subjectcode'] as String?;
    subjectid = json['subjectid'] as String?;
    subjectdesc = json['subjectdesc'] as String?;
  }
  String? staffname;
  String? subjectcode;
  String? subjectid;
  String? subjectdesc;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['staffname'] = staffname;
    data['subjectcode'] = subjectcode;
    data['subjectid'] = subjectid;
    data['subjectdesc'] = subjectdesc;
    return data;
  }
}
