class ErrorModel {

  ErrorModel({this.status, this.message, this.data});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    status = json['Status']as String?;
    message = json['Message']as String?;
    data = json['Data']as String?;
  }
  String? status;
  String? message;
  String? data;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Status'] = status;
    data['Message'] = message;
    data['Data'] = this.data;
    return data;
  }
}
