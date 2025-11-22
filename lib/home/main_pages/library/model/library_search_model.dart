import 'dart:developer';

class BooksearchList {
  BooksearchList({this.status, this.message, this.data});

  BooksearchList.fromJson(Map<String, dynamic> json) {
    log("json trans $json");
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <BookSearchData>[];
      for (final v in json['Data'] as List<dynamic>) {
        data!.add(BookSearchData.fromJson(v as Map<String, dynamic>));
      }
    }
  }
  String? status;
  String? message;
  List<BookSearchData>? data;

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

class BookSearchData {
  BookSearchData({
    this.accessionnumber,
    this.availability,
    this.authorname,
    this.publishername,
    this.edition,
    this.borrow,
    this.title,
    this.department,
    this.booknumber,
    this.classificationNumber,
    this.inhand,
  });

  BookSearchData.fromJson(Map<String, dynamic> json) {
    accessionnumber = json['accessionnumber'] as String?;
    availability = json['availability'] as String?;
    authorname = json['authorname'] as String?;
    publishername = json['publishername'] as String?;
    edition = json['edition'] as String?;
    borrow = json['borrow'] as dynamic;
    title = json['title'] as String?;
    department = json['department'] as String?;
    booknumber = json['booknumber'] as String?;
    classificationNumber = json['classification_number'] as String?;
    inhand = json['inhand'] as dynamic;
  }
  String? accessionnumber;
  String? availability;
  String? authorname;
  String? publishername;
  String? edition;
  dynamic borrow;
  String? title;
  String? department;
  String? booknumber;
  String? classificationNumber;
  dynamic inhand;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['accessionnumber'] = accessionnumber;
    data['availability'] = availability;
    data['authorname'] = authorname;
    data['publishername'] = publishername;
    data['edition'] = edition;
    data['borrow'] = borrow;
    data['title'] = title;
    data['department'] = department;
    data['booknumber'] = booknumber;
    data['classification_number'] = classificationNumber;
    data['inhand'] = inhand;
    return data;
  }
}
