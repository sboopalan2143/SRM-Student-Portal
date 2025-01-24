class McqSheduleModel {
  McqSheduleModel({this.status, this.message, this.data});

  McqSheduleModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <McqSheduleData>[];
      // ignore: inference_failure_on_untyped_parameter
      json['Data'].forEach((v) {
        data!.add(McqSheduleData.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  String? status;
  String? message;
  List<McqSheduleData>? data;

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

class McqSheduleData {
  McqSheduleData({
    this.date,
    this.endtime,
    this.minmarktopass,
    this.subjectid,
    this.timelimit,
    this.subjectdesc,
    this.noofquestions,
    this.termsandconditionremarks,
    this.mcqtemplateid,
    this.examdate,
    this.examenddate,
    this.scheduleid,
    this.marksperquestions,
  });
  McqSheduleData.fromJson(Map<String, dynamic> json) {
    date = json['date'] as String?;
    endtime = json['endtime'] as String?;
    minmarktopass = json['minmarktopass'] as String?;
    subjectid = json['subjectid'] as String?;
    timelimit = json['timelimit'] as String?;
    subjectdesc = json['subjectdesc'] as String?;
    noofquestions = json['noofquestions'] as String?;
    termsandconditionremarks = json['termsandconditionremarks'] as String?;
    mcqtemplateid = json['mcqtemplateid'] as String?;
    examdate = json['examdate'] as String?;
    examenddate = json['examenddate'] as String?;
    scheduleid = json['scheduleid'] as String?;
    marksperquestions = json['marksperquestions'] as String?;
  }
  String? date;
  String? endtime;
  String? minmarktopass;
  String? subjectid;
  String? timelimit;
  String? subjectdesc;
  String? noofquestions;
  String? termsandconditionremarks;
  String? mcqtemplateid;
  String? examdate;
  String? examenddate;
  String? scheduleid;
  String? marksperquestions;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['date'] = date;
    data['endtime'] = endtime;
    data['minmarktopass'] = minmarktopass;
    data['subjectid'] = subjectid;
    data['timelimit'] = timelimit;
    data['subjectdesc'] = subjectdesc;
    data['noofquestions'] = noofquestions;
    data['termsandconditionremarks'] = termsandconditionremarks;
    data['mcqtemplateid'] = mcqtemplateid;
    data['examdate'] = examdate;
    data['examenddate'] = examenddate;
    data['scheduleid'] = scheduleid;
    data['marksperquestions'] = marksperquestions;
    return data;
  }
}
