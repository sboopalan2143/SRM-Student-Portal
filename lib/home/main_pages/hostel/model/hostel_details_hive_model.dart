import 'package:hive/hive.dart';

part 'hostel_details_hive_model.g.dart';

@HiveType(typeId: 15)
class GetHostelHiveData {
  GetHostelHiveData({
    this.hostelname,
    this.roomname,
    this.academicyear,
    this.alloteddate,
    this.roomtype,
  });

  GetHostelHiveData.fromJson(Map<String, dynamic> json) {
    hostelname = json['hostelname'] as String?;
    roomname = json['roomname'] as String?;
    academicyear = json['academicyear'] as String?;
    alloteddate = json['alloteddate'] as String?;
    roomtype = json['roomtype'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['hostelname'] = hostelname;
    data['roomname'] = roomname;
    data['academicyear'] = academicyear;
    data['alloteddate'] = alloteddate;
    data['roomtype'] = roomtype;
    return data;
  }

  static final empty = GetHostelHiveData(
    hostelname: '',
    roomname: '',
    academicyear: '',
    alloteddate: '',
    roomtype: '',
  );

  @HiveField(0)
  String? hostelname;

  @HiveField(1)
  String? roomname;

  @HiveField(2)
  String? academicyear;

  @HiveField(3)
  String? alloteddate;

  @HiveField(4)
  String? roomtype;
}
