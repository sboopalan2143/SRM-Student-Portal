class BooksearchList {
  BooksearchList({this.status, this.message, this.data});

  BooksearchList.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <BookSearchData>[];
      json['Data'].forEach((dynamic v) {
        data!.add(BookSearchData.fromJson(v as Map<String, dynamic>));
      });
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
  BookSearchData(
      {this.accessionnumber,
      this.authorname,
      this.publishername,
      this.edition,
      this.borrow,
      this.title,
      this.department,
      this.booknumber,
      this.classificationNumber,
      this.inhand});

  BookSearchData.fromJson(Map<String, dynamic> json) {
    accessionnumber = json['accessionnumber'] as String?;
    authorname = json['authorname'] as String?;
    publishername = json['publishername'] as String?;
    edition = json['edition'] as String?;
    borrow = json['borrow'] as String?;
    title = json['title'] as String?;
    department = json['department'] as String?;
    booknumber = json['booknumber'] as String?;
    classificationNumber = json['classification_number'] as String?;
    inhand = json['inhand'] as String?;
  }
  String? accessionnumber;
  String? authorname;
  String? publishername;
  String? edition;
  String? borrow;
  String? title;
  String? department;
  String? booknumber;
  String? classificationNumber;
  String? inhand;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessionnumber'] = accessionnumber;
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
