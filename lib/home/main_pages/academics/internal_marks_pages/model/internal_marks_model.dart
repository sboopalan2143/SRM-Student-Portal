class GetInternalMarkDetails {
  String? status;
  String? message;
  List<InternalMarkData>? data;

  GetInternalMarkDetails({this.status, this.message, this.data});

  GetInternalMarkDetails.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <InternalMarkData>[];
      json['Data'].forEach((v) {
        data!.add(new InternalMarkData.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = status;
    data['Message'] = message;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InternalMarkData {
  String? sumofmarks;
  String? subjectcode;
  String? sumofmaxmarks;
  String? subjectdesc;

  InternalMarkData(
      {this.sumofmarks,
      this.subjectcode,
      this.sumofmaxmarks,
      this.subjectdesc});

  InternalMarkData.fromJson(Map<String, dynamic> json) {
    sumofmarks = json['sumofmarks'] as String?;
    subjectcode = json['subjectcode'] as String?;
    sumofmaxmarks = json['sumofmaxmarks'] as String?;
    subjectdesc = json['subjectdesc'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sumofmarks'] = sumofmarks;
    data['subjectcode'] = subjectcode;
    data['sumofmaxmarks'] = sumofmaxmarks;
    data['subjectdesc'] = subjectdesc;
    return data;
  }
}
