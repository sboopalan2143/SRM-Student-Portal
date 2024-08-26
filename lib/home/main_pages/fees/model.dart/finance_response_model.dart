class FinanceResponseModel {
  FinanceResponseModel({this.status, this.message, this.data});

  FinanceResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <FinanceData>[];
      for (final v in json['Data'] as List<dynamic>) {
        data!.add(FinanceData.fromJson(v as Map<String, dynamic>));
      }
    }
  }
  String? status;
  String? message;
  List<FinanceData>? data;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Status'] = status;
    data['Message'] = message;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FinanceData {
  FinanceData({
    this.amountcollected,
    this.modeoftransaction,
    this.receiptnum,
    this.duedate,
    this.duename,
    this.dueamount,
    this.term,
    this.receiptdate,
  });

  FinanceData.fromJson(Map<String, dynamic> json) {
    amountcollected = json['amountcollected'] as String?;
    modeoftransaction = json['modeoftransaction'] as String?;
    receiptnum = json['receiptnum'] as String?;
    duedate = json['duedate'] as String?;
    duename = json['duename'] as String?;
    dueamount = json['dueamount'] as String?;
    term = json['term'] as String?;
    receiptdate = json['receiptdate'] as String?;
  }
  String? amountcollected;
  String? modeoftransaction;
  String? receiptnum;
  String? duedate;
  String? duename;
  String? dueamount;
  String? term;
  String? receiptdate;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['amountcollected'] = amountcollected;
    data['modeoftransaction'] = modeoftransaction;
    data['receiptnum'] = receiptnum;
    data['duedate'] = duedate;
    data['duename'] = duename;
    data['dueamount'] = dueamount;
    data['term'] = term;
    data['receiptdate'] = receiptdate;
    return data;
  }
}
