import 'package:cloud_firestore/cloud_firestore.dart';

class Category {

  String? name;
  String? subject;
  String? imgUrl;

  Category({
    this.name,
    this.subject,
    this.imgUrl,
  });


  Category.fromJson(Map<String, dynamic> json)
  {
    name = json["name"];
    subject = json['subject'];
    imgUrl = json['imgUrl'];
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["name"] = name;
    data['subject'] = subject;
    data['imgUrl'] = imgUrl;

    return data;
  }




}