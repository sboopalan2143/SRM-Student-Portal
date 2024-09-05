class GrievanceSubTypeModel {
  String? status;
  String? message;
  List<GrievanceSubTypeData>? data;

  GrievanceSubTypeModel({this.status, this.message, this.data});

  GrievanceSubTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <GrievanceSubTypeData>[];
      json['Data'].forEach((v) {
        data!.add(new GrievanceSubTypeData.fromJson(v as Map<String, dynamic>));
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

class GrievanceSubTypeData {
  String? grievancesubcategorydesc;
  String? grievancesubcategoryid;

  GrievanceSubTypeData(
      {this.grievancesubcategorydesc, this.grievancesubcategoryid});

  GrievanceSubTypeData.fromJson(Map<String, dynamic> json) {
    grievancesubcategorydesc = json['grievancesubcategorydesc'] as String?;
    grievancesubcategoryid = json['grievancesubcategoryid'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grievancesubcategorydesc'] = this.grievancesubcategorydesc;
    data['grievancesubcategoryid'] = this.grievancesubcategoryid;
    return data;
  }
}
