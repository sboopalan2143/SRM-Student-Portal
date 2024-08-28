class GetLibraryTransaction {
  String? status;
  String? message;
  List<LibraryTransactionData>? data;

  GetLibraryTransaction({this.status, this.message, this.data});

  GetLibraryTransaction.fromJson(Map<String, dynamic> json) {
    status = json['Status']as String?;
    message = json['Message']as String?;
    if (json['Data'] != null) {
      data = <LibraryTransactionData>[];
      json['Data'].forEach((v) {
        data!.add(new LibraryTransactionData.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = status;
    data['Message'] = message;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LibraryTransactionData {
  String? membercode;
  String? membertype;
  String? policyname;
  String? membername;
  String? status;

  LibraryTransactionData(
      {this.membercode,
      this.membertype,
      this.policyname,
      this.membername,
      this.status});

  LibraryTransactionData.fromJson(Map<String, dynamic> json) {
    membercode = json['membercode']as String?;
    membertype = json['membertype']as String?;
    policyname = json['policyname']as String?;
    membername = json['membername']as String?;
    status = json['status']as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['membercode'] = membercode;
    data['membertype'] = membertype;
    data['policyname'] = policyname;
    data['membername'] = membername;
    data['status'] = status;
    return data;
  }
}