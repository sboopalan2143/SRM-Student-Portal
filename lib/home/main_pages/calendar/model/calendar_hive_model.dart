import 'package:hive/hive.dart';


part 'calendar_hive_model.g.dart';

@HiveType(typeId: 31)
class CalendarHiveModelData {
  CalendarHiveModelData({
    this.date,
    this.daystatus,
    this.holidaystatus,
    this.weekdayno,
    this.semester,
    this.day,
    this.remarks,
    this.dayorder,
  });

  CalendarHiveModelData.fromJson(Map<String, dynamic> json) {
    date = json['date'] as String?;
    daystatus = json['daystatus'] as String?;
    holidaystatus = json['holidaystatus'] as String?;
    weekdayno = json['weekdayno'] as String?;
    semester = json['semester'] as String?;
    day = json['day'] as String?;
    remarks = json['remarks'] as String?;
    dayorder = json['dayorder'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['date'] = date;
    data['daystatus'] = daystatus;
    data['holidaystatus'] = holidaystatus;
    data['weekdayno'] = weekdayno;
    data['semester'] = semester;
    data['day'] = day;
    data['remarks'] = remarks;
    data['dayorder'] = dayorder;
    return data;
  }

  static final empty = CalendarHiveModelData(
    date: '',
    daystatus: '',
    holidaystatus: '',
    weekdayno: '',
    semester: '',
    day: '',
    remarks: '',
    dayorder: '',
  );

  @HiveField(0)
  String? date;

  @HiveField(1)
  String? daystatus;

  @HiveField(2)
  String? holidaystatus;

  @HiveField(3)
  String? weekdayno;

  @HiveField(4)
  String? semester;

  @HiveField(5)
  String? day;

  @HiveField(6)
  String? remarks;

  @HiveField(7)
  String? dayorder;
}
