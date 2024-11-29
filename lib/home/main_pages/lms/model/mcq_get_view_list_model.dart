class GetMCQViewDetails {
  String? status;
  String? message;
  List<MCQGetViewModelData>? data;

  GetMCQViewDetails({this.status, this.message, this.data});

  GetMCQViewDetails.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <MCQGetViewModelData>[];
      for (final v in json['Data'] as List<dynamic>) {
        data!.add(MCQGetViewModelData.fromJson(v as Map<String, dynamic>));
      }
    }
  }

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

class MCQGetViewModelData {
  String? answerid;
  String? youranswerid;
  String? questionfilename;
  String? mcqexamid;
  String? youranswervalid;
  String? youranswerfilename;
  String? youranswer;
  String? tamil;
  String? questiondesc;
  String? totalmarks;
  String? answer;
  String? yourmarks;
  String? mcqanswertype;

  MCQGetViewModelData({
    this.answerid,
    this.youranswerid,
    this.questionfilename,
    this.mcqexamid,
    this.youranswervalid,
    this.youranswerfilename,
    this.youranswer,
    this.tamil,
    this.questiondesc,
    this.totalmarks,
    this.answer,
    this.yourmarks,
    this.mcqanswertype,
  });

  MCQGetViewModelData.fromJson(Map<String, dynamic> json) {
    answerid = json['answerid'] as String?;
    youranswerid = json['youranswerid'] as String?;
    questionfilename = json['questionfilename'] as String?;
    mcqexamid = json['mcqexamid'] as String?;
    youranswervalid = json['youranswervalid'] as String?;
    youranswerfilename = json['youranswerfilename'] as String?;
    youranswer = json['youranswer'] as String?;
    tamil = json['tamil'] as String?;
    questiondesc = json['questiondesc'] as String?;
    totalmarks = json['totalmarks'] as String?;
    answer = json['answer'] as String?;
    yourmarks = json['yourmarks'] as String?;
    mcqanswertype = json['mcqanswertype'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['answerid'] = answerid;
    data['youranswerid'] = youranswerid;
    data['questionfilename'] = questionfilename;
    data['mcqexamid'] = mcqexamid;
    data['youranswervalid'] = youranswervalid;
    data['youranswerfilename'] = youranswerfilename;
    data['youranswer'] = youranswer;
    data['tamil'] = tamil;
    data['questiondesc'] = questiondesc;
    data['totalmarks'] = totalmarks;
    data['answer'] = answer;
    data['yourmarks'] = yourmarks;
    data['mcqanswertype'] = mcqanswertype;
    return data;
  }
}
