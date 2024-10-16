import 'package:hive/hive.dart';

part 'hostel_leave_application_hive_model.g.dart';

@HiveType(typeId: 17)
class HostelLeaveHiveData {
  HostelLeaveHiveData({
    this.leavetodate,
    this.reason,
    this.leavefromdate,
    this.status,
  });

  HostelLeaveHiveData.fromJson(Map<String, dynamic> json) {
    leavetodate = json['leavetodate'] as String?;
    reason = json['reason'] as String?;
    leavefromdate = json['leavefromdate'] as String?;
    status = json['status'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['leavetodate'] = leavetodate;
    data['reason'] = reason;
    data['leavefromdate'] = leavefromdate;
    data['status'] = status;
    return data;
  }

  @HiveField(0)
  String? leavetodate;

  @HiveField(1)
  String? reason;

  @HiveField(2)
  String? leavefromdate;

  @HiveField(3)
  String? status;
}
