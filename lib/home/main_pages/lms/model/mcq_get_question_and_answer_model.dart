class McqQuestionandAnswerModel {
  McqQuestionandAnswerModel({this.status, this.message, this.data});

  McqQuestionandAnswerModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <McqGetQuestionAndAnswerData>[];
      // ignore: inference_failure_on_untyped_parameter
      json['Data'].forEach((v) {
        data!.add(
            McqGetQuestionAndAnswerData.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  String? status;
  String? message;
  List<McqGetQuestionAndAnswerData>? data;

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

class McqGetQuestionAndAnswerData {
  McqGetQuestionAndAnswerData({
    this.tamil,
    this.questionid,
    this.questiondesc,
    this.answer,
    this.questionimage,
    this.mcqanswertype,
  });

  McqGetQuestionAndAnswerData.fromJson(Map<String, dynamic> json) {
    tamil = json['tamil'] as String?;
    questionid = json['questionid'] as String?;
    questiondesc = json['questiondesc'] as String?;
    answer = json['answer'] as String?;
    questionimage = json['questionimage'] as String?;
    mcqanswertype = json['mcqanswertype'] as String?;
  }
  String? tamil;
  String? questionid;
  String? questiondesc;
  String? answer;
  String? questionimage;
  String? mcqanswertype;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['tamil'] = tamil;
    data['questionid'] = questionid;
    data['questiondesc'] = questiondesc;
    data['answer'] = answer;
    data['questionimage'] = questionimage;
    data['mcqanswertype'] = mcqanswertype;
    return data;
  }
}
