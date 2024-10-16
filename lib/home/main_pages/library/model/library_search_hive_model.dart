import 'package:hive/hive.dart';

part 'library_search_hive_model.g.dart';

@HiveType(typeId: 20)
class BookSearchHiveData {
  BookSearchHiveData({
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

  BookSearchHiveData.fromJson(Map<String, dynamic> json) {
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

  @HiveField(0)
  String? accessionnumber;

  @HiveField(1)
  String? availability;

  @HiveField(2)
  String? authorname;

  @HiveField(3)
  String? publishername;

  @HiveField(4)
  String? edition;

  @HiveField(5)
  dynamic borrow;

  @HiveField(6)
  String? title;

  @HiveField(7)
  String? department;

  @HiveField(8)
  String? booknumber;

  @HiveField(9)
  String? classificationNumber;

  @HiveField(10)
  dynamic inhand;
}
