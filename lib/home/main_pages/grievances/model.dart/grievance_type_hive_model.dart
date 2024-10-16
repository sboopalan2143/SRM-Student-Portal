import 'package:hive/hive.dart';

part 'grievance_type_hive_model.g.dart';

@HiveType(typeId: 11)
class GrievanceTypeHiveData {
  GrievanceTypeHiveData({this.grievancetype, this.grievancetypeid});

  GrievanceTypeHiveData.fromJson(Map<String, dynamic> json) {
    grievancetype = json['grievancetype'] as String?;
    grievancetypeid = json['grievancetypeid'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['grievancetype'] = grievancetype;
    data['grievancetypeid'] = grievancetypeid;
    return data;
  }

  static final empty = GrievanceTypeHiveData(
    grievancetype: 'Grievance Type',
    grievancetypeid: '',
  );

  @HiveField(0)
  String? grievancetype;

  @HiveField(1)
  String? grievancetypeid;
}
