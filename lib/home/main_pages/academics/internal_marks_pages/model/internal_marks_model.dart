class GetInternalMarkDetails {
  GetInternalMarkDetails({this.status, this.message, this.data});

  GetInternalMarkDetails.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <InternalMarkData>[];
      for (final v in json['Data'] as List<dynamic>) {
        data!.add(InternalMarkData.fromJson(v as Map<String, dynamic>));
      }
    }
  }
  String? status;
  String? message;
  List<InternalMarkData>? data;

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

class InternalMarkData {
  InternalMarkData({
    this.sumofmarks,
    this.subjectcode,
    this.sumofmaxmarks,
    this.subjectdesc,
  });

  InternalMarkData.fromJson(Map<String, dynamic> json) {
    sumofmarks = json['sumofmarks'] as String?;
    subjectcode = json['subjectcode'] as String?;
    sumofmaxmarks = json['sumofmaxmarks'] as String?;
    subjectdesc = json['subjectdesc'] as String?;
  }
  String? sumofmarks;
  String? subjectcode;
  String? sumofmaxmarks;
  String? subjectdesc;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['sumofmarks'] = sumofmarks;
    data['subjectcode'] = subjectcode;
    data['sumofmaxmarks'] = sumofmaxmarks;
    data['subjectdesc'] = subjectdesc;
    return data;
  }
}
