// class CalenderModelData {
//   CalenderModelData.fromJson(Map<String, dynamic> json) {
//     status = json['Status'] as String?;
//     message = json['Message'] as String?;
//     if (json['Data'] != null) {
//       data = <CalendarData>[];
//       json['Data'].forEach((v) {
//         data!.add(CalendarData.fromJson(v as Map<String, dynamic>));
//       });
//     }
//   }

//   CalenderModelData({this.status, this.message, this.data});
//   String? status;
//   String? message;
//   List<CalendarData>? data;

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['Status'] = status;
//     data['Message'] = message;
//     if (this.data != null) {
//       data['Data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class CalendarData {
//   CalendarData.fromJson(Map<String, dynamic> json) {
//     date = json['date'] as String?;
//     daystatus = json['daystatus'] as String?;
//     holidaystatus = json['holidaystatus'] as String?;
//     weekdayno = json['weekdayno'] as String?;
//     semester = json['semester'] as String?;
//     day = json['day'] as String?;
//     remarks = json['remarks'] as String?;
//     dayorder = json['dayorder'] as String?;
//   }

//   CalendarData({
//     this.date,
//     this.daystatus,
//     this.holidaystatus,
//     this.weekdayno,
//     this.semester,
//     this.day,
//     this.remarks,
//     this.dayorder,
//   });
//   String? date;
//   String? daystatus;
//   String? holidaystatus;
//   String? weekdayno;
//   String? semester;
//   String? day;
//   String? remarks;
//   String? dayorder;

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['date'] = date;
//     data['daystatus'] = daystatus;
//     data['holidaystatus'] = holidaystatus;
//     data['weekdayno'] = weekdayno;
//     data['semester'] = semester;
//     data['day'] = day;
//     data['remarks'] = remarks;
//     data['dayorder'] = dayorder;
//     return data;
//   }
// }
