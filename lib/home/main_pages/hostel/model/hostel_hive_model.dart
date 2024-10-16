import 'package:hive/hive.dart';

part 'hostel_hive_model.g.dart';

@HiveType(typeId: 16)
class HostelHiveData {
  HostelHiveData({this.hostelname, this.hostelid});

  HostelHiveData.fromJson(Map<String, dynamic> json) {
    hostelname = json['hostelname'] as String?;
    hostelid = json['hostelid'] as String?;
  }
  

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['hostelname'] = hostelname;
    data['hostelid'] = hostelid;
    return data;
  }

  static final empty = HostelHiveData(hostelname: 'Select Hostel', hostelid: '');

  @HiveField(0)
  String? hostelname;

  @HiveField(1)
  String? hostelid;

  
}
