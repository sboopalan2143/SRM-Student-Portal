import 'package:hive/hive.dart';

part 'finance_response_hive_model.g.dart';

@HiveType(typeId: 7)
class FinanceHiveData {
  FinanceHiveData({
    this.amountcollected,
    this.modeoftransaction,
    this.receiptnum,
    this.duedate,
    this.duename,
    this.dueamount,
    this.term,
    this.receiptdate,
  });

  FinanceHiveData.fromJson(Map<String, dynamic> json) {
    amountcollected = json['amountcollected'] as String?;
    modeoftransaction = json['modeoftransaction'] as String?;
    receiptnum = json['receiptnum'] as String?;
    duedate = json['duedate'] as String?;
    duename = json['duename'] as String?;
    dueamount = json['dueamount'] as String?;
    term = json['term'] as String?;
    receiptdate = json['receiptdate'] as String?;
  }

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

  @HiveField(0)
  String? amountcollected;

  @HiveField(1)
  String? modeoftransaction;

  @HiveField(2)
  String? receiptnum;

  @HiveField(3)
  String? duedate;

  @HiveField(4)
  String? duename;

  @HiveField(5)
  String? dueamount;

  @HiveField(6)
  String? term;

  @HiveField(7)
  String? receiptdate;
}
