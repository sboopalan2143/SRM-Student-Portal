import 'package:hive/hive.dart';

part 'grievance_category_hive_model.g.dart';

@HiveType(typeId: 9)
class GrievanceCategoryHiveData {
  GrievanceCategoryHiveData({
    this.grievancekcategory,
    this.grievancekcategoryid,
  });

  GrievanceCategoryHiveData.fromJson(Map<String, dynamic> json) {
    grievancekcategory = json['grievancekcategory'] as String?;
    grievancekcategoryid = json['grievancekcategoryid'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['grievancekcategory'] = grievancekcategory;
    data['grievancekcategoryid'] = grievancekcategoryid;
    return data;
  }

  static final empty = GrievanceCategoryHiveData(
    grievancekcategory: 'Grievances Category',
    grievancekcategoryid: '',
  );

  @HiveField(0)
  String? grievancekcategory;

  @HiveField(1)
  String? grievancekcategoryid;
}
