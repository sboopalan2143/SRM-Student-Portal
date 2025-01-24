// class GetLibraryTransaction {
//   GetLibraryTransaction({this.status, this.message, this.data});

//   GetLibraryTransaction.fromJson(Map<String, dynamic> json) {
//     status = json['Status'] as String?;
//     message = json['Message'] as String?;
//     if (json['Data'] != null) {
//       data = <LibraryTransactionData>[];
//      for (final v in json['Data'] as List<dynamic>){
//         data!.add(
//              LibraryTransactionData.fromJson(v as Map<String, dynamic>),);
//       }
//     }
//   }
//   String? status;
//   String? message;
//   List<LibraryTransactionData>? data;

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

// class LibraryTransactionData {

//   LibraryTransactionData({
//     this.membercode,
//     this.membertype,
//     this.policyname,
//     this.membername,
//     this.status,
//     this.accessionno,
//     this.returndate,
//     this.duedate,
//     this.fineamount,
//     this.title,
//     this.issuedate,
//   });
//   LibraryTransactionData.fromJson(Map<String, dynamic> json) {
//     membercode = json['membercode'] as String?;
//     membertype = json['membertype'] as String?;
//     policyname = json['policyname'] as String?;
//     membername = json['membername'] as String?;
//     status = json['status'] as String?;
//     accessionno = json['accessionno'] as String?;
//     returndate = json['returndate'] as String?;
//     duedate = json['duedate'] as String?;
//     fineamount = json['fineamount'] as String?;
//     title = json['title'] as String?;
//     issuedate = json['issuedate'] as String?;
//   }
//   String? membercode;
//   String? membertype;
//   String? policyname;
//   String? membername;
//   String? status;
//   String? accessionno;
//   String? returndate;
//   String? duedate;
//   String? fineamount;
//   String? title;
//   String? issuedate;

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['membercode'] = membercode;
//     data['membertype'] = membertype;
//     data['policyname'] = policyname;
//     data['membername'] = membername;
//     data['status'] = status;
//     data['accessionno'] = accessionno;
//     data['returndate'] = returndate;
//     data['duedate'] = duedate;
//     data['fineamount'] = fineamount;
//     data['title'] = title;
//     data['issuedate'] = issuedate;
//     return data;
//   }
// }
