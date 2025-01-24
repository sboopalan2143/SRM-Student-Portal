class ReplayFacultyComment {
  ReplayFacultyComment({this.status, this.message, this.data});

  ReplayFacultyComment.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <ReplayFacultyCommentData>[];
      for (final v in json['Data'] as List<dynamic>) {
        data!.add(ReplayFacultyCommentData.fromJson(v as Map<String, dynamic>));
      }
    }
  }
  String? status;
  String? message;
  List<ReplayFacultyCommentData>? data;

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

class ReplayFacultyCommentData {
  ReplayFacultyCommentData({
    this.replynames,
    this.replytime,
    this.replycomments,
  });

  ReplayFacultyCommentData.fromJson(Map<String, dynamic> json) {
    replynames = json['replynames'] as String?;
    replytime = json['replytime'] as String?;
    replycomments = json['replycomments'] as String?;
  }
  String? replynames;
  String? replytime;
  String? replycomments;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['replynames'] = replynames;
    data['replytime'] = replytime;
    data['replycomments'] = replycomments;
    return data;
  }
}
