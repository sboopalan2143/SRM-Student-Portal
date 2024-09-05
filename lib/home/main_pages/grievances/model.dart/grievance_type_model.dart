class GrievanceTypeModel {
  String? status;
  String? message;
  List<GrievanceData>? data;

  GrievanceTypeModel({this.status, this.message, this.data});

  GrievanceTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['Status']as String?;
    message = json['Message']as String?;
    if (json['Data'] != null) {
      data = <GrievanceData>[];
      json['Data'].forEach((v) {
        data!.add(new GrievanceData.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GrievanceData {
  String? grievancetype;
  String? grievancetypeid;

  GrievanceData({this.grievancetype, this.grievancetypeid});

  GrievanceData.fromJson(Map<String, dynamic> json) {
    grievancetype = json['grievancetype']as String?;
    grievancetypeid = json['grievancetypeid']as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grievancetype'] = this.grievancetype;
    data['grievancetypeid'] = this.grievancetypeid;
    return data;
  }
}