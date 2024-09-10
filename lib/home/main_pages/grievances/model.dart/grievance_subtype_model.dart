class GrievanceSubTypeModel {
  GrievanceSubTypeModel({this.status, this.message, this.data});

  GrievanceSubTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <GrievanceSubTypeData>[];
      // ignore: avoid_dynamic_calls
     for (final v in json['Data'] as List<dynamic>) {
        data!.add(GrievanceSubTypeData.fromJson(v as Map<String, dynamic>));
      }
    }
  }
  String? status;
  String? message;
  List<GrievanceSubTypeData>? data;

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

class GrievanceSubTypeData {
  GrievanceSubTypeData(
      {this.grievancesubcategorydesc, this.grievancesubcategoryid});

  GrievanceSubTypeData.fromJson(Map<String, dynamic> json) {
    grievancesubcategorydesc = json['grievancesubcategorydesc'] as String?;
    grievancesubcategoryid = json['grievancesubcategoryid'] as String?;
  }
  String? grievancesubcategorydesc;
  String? grievancesubcategoryid;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['grievancesubcategorydesc'] = grievancesubcategorydesc;
    data['grievancesubcategoryid'] = grievancesubcategoryid;
    return data;
  }

  static final empty = GrievanceSubTypeData(
    grievancesubcategorydesc: 'Grievance Subtype',
    grievancesubcategoryid: '',
  );
}
