import 'package:hive/hive.dart';

part 'grievance_subtype_hive_model.g.dart';

@HiveType(typeId: 10)
class GrievanceSubTypeHiveData {
  GrievanceSubTypeHiveData({
    this.grievancesubcategorydesc,
    this.grievancesubcategoryid,
  });

  GrievanceSubTypeHiveData.fromJson(Map<String, dynamic> json) {
    grievancesubcategorydesc = json['grievancesubcategorydesc'] as String?;
    grievancesubcategoryid = json['grievancesubcategoryid'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['grievancesubcategorydesc'] = grievancesubcategorydesc;
    data['grievancesubcategoryid'] = grievancesubcategoryid;
    return data;
  }

  static final empty = GrievanceSubTypeHiveData(
    grievancesubcategorydesc: 'Grievance Subtype',
    grievancesubcategoryid: '',
  );

  @HiveField(0)
  String? grievancesubcategorydesc;

  @HiveField(1)
  String? grievancesubcategoryid;
}
