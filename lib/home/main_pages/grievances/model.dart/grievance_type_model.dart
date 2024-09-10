class GrievanceTypeModel {
  GrievanceTypeModel({this.status, this.message, this.data});

  GrievanceTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <GrievanceData>[];
      // ignore: inference_failure_on_untyped_parameter
      for (final v in json['Data'] as List<dynamic>)  {
        data!.add(GrievanceData.fromJson(v as Map<String, dynamic>));
      }
    }
  }
  String? status;
  String? message;
  List<GrievanceData>? data;

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

class GrievanceData {
  GrievanceData({this.grievancetype, this.grievancetypeid});

  GrievanceData.fromJson(Map<String, dynamic> json) {
    grievancetype = json['grievancetype'] as String?;
    grievancetypeid = json['grievancetypeid'] as String?;
  }
  String? grievancetype;
  String? grievancetypeid;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['grievancetype'] = grievancetype;
    data['grievancetypeid'] = grievancetypeid;
    return data;
  }

  static final empty = GrievanceData(
    grievancetype: 'Grievance Type',
    grievancetypeid: '',
  );
}
