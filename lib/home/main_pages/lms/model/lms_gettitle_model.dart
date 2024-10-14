class GetTitleListModel {
  GetTitleListModel({this.status, this.message, this.data});

  GetTitleListModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <LmsGetTitleData>[];
      
      for (final v in json['Data'] as List<dynamic>) {
        data!.add(LmsGetTitleData.fromJson(v as Map<String, dynamic>));
      }
    }
  }
  String? status;
  String? message;
  List<LmsGetTitleData>? data;

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

class LmsGetTitleData {
  LmsGetTitleData({
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

  LmsGetTitleData.fromJson(Map<String, dynamic> json) {
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
  String? classworktypeid;
  String? classworkid;
  String? privatecomment;
  String? enddatetime;
  String? classworktypedesc;
  String? classcomment;
  String? newwork;
  String? title;
  String? topicdesc;
  String? startdatetime;

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
}
