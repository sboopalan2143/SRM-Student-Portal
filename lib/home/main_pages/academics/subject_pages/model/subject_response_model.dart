class SubjectResponseModel {
  SubjectResponseModel({this.status, this.message, this.data});

  SubjectResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <Data>[];
      for (final v in json['Data'] as List<dynamic>) {
        data!.add(Data.fromJson(v as Map<String, dynamic>));
      }
    }
  }
  String? status;
  String? message;
  List<Data>? data;

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

class Data {
  Data({this.subjectdetails});

  Data.fromJson(Map<String, dynamic> json) {
    subjectdetails = json['subjectdetails'] as String?;
  }
  String? subjectdetails;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['subjectdetails'] = subjectdetails;
    return data;
  }
}
