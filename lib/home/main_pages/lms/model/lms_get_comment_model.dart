class GetCommentModel {
  GetCommentModel({this.status, this.message, this.data});

  GetCommentModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <GetCommentData>[];
      // ignore: inference_failure_on_untyped_parameter, avoid_dynamic_calls
      json['Data'].forEach((v) {
        data!.add(GetCommentData.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  String? status;
  String? message;
  List<GetCommentData>? data;

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

class GetCommentData {
  GetCommentData({
    this.studentid,
    this.studentclassworkcommentid,
    this.names,
    this.comments,
    this.classworkid,
    this.commentdatetime,
    this.employeeid,
  });

  GetCommentData.fromJson(Map<String, dynamic> json) {
    studentid = json['studentid'] as String;
    studentclassworkcommentid = json['studentclassworkcommentid'] as String;
    names = json['names'] as String;
    comments = json['comments'] as String;
    classworkid = json['classworkid'] as String;
    commentdatetime = json['commentdatetime'] as String;
    employeeid = json['employeeid'] as String;
  }
  String? studentid;
  String? studentclassworkcommentid;
  String? names;
  String? comments;
  String? classworkid;
  String? commentdatetime;
  String? employeeid;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['studentid'] = studentid;
    data['studentclassworkcommentid'] = studentclassworkcommentid;
    data['names'] = names;
    data['comments'] = comments;
    data['classworkid'] = classworkid;
    data['commentdatetime'] = commentdatetime;
    data['employeeid'] = employeeid;
    return data;
  }
}
