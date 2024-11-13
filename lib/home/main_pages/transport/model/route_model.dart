// class TransportRequestRoutes {
//   TransportRequestRoutes({this.status, this.message, this.data});

//   TransportRequestRoutes.fromJson(Map<String, dynamic> json) {
//     status = json['Status'] as String?;
//     message = json['Message'] as String?;
//     if (json['Data'] != null) {
//       data = <RouteDetailsData>[];
//       for (final v in json['Data'] as List<dynamic>) {
//         data!.add(RouteDetailsData.fromJson(v as Map<String, dynamic>));
//       }
//     }
//   }
//   String? status;
//   String? message;
//   List<RouteDetailsData>? data;

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['Status'] = status;
//     data['Message'] = message;
//     if (this.data != null) {
//       data['Data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class RouteDetailsData {
//   RouteDetailsData({this.busrouteid, this.busroutename});

//   RouteDetailsData.fromJson(Map<String, dynamic> json) {
//     busrouteid = json['busrouteid'] as String?;
//     busroutename = json['busroutename'] as String?;
//   }
//   String? busrouteid;
//   String? busroutename;

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['busrouteid'] = busrouteid;
//     data['busroutename'] = busroutename;
//     return data;
//   }

//   static final empty = RouteDetailsData(
//     busrouteid: '',
//     busroutename: 'Route Data',
//   );
// }
