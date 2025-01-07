// import 'package:hive/hive.dart';

// part 'get_fees_details_hive_model.g.dart';

// @HiveType(typeId: 8)
// class GetFeesHiveData {

//   GetFeesHiveData(
//       {this.duedate,
//       this.duename,
//       this.dueamount,
//       this.duedescription,
//       this.amtcollected,
//       this.currentdue,});

//   GetFeesHiveData.fromJson(Map<String, dynamic> json) {
//     duedate = json['duedate'] as String?;
//     duename = json['duename'] as String?;
//     dueamount = json['dueamount'] as String?;
//     duedescription = json['duedescription'] as String?;
//     amtcollected = json['amtcollected'] as String?;
//     currentdue = json['currentdue'] as String?;
//   }
 

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['duedate'] = duedate;
//     data['duename'] = duename;
//     data['dueamount'] = dueamount;
//     data['duedescription'] = duedescription;
//     data['amtcollected'] = amtcollected;
//     data['currentdue'] = currentdue;
//     return data;
//   }


//   @HiveField(0)
//   String? duedate;

//   @HiveField(1)
//   String? duename;

//   @HiveField(2)
//   String? dueamount;

//   @HiveField(3)
//   String? duedescription;

//   @HiveField(4)
//   String? amtcollected;

//   @HiveField(5)
//   String? currentdue;

  
// }
