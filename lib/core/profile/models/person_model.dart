import 'package:cloud_firestore/cloud_firestore.dart';

class Person {
  String? userName;
  String? userEmail;
  String? userUID;
  String? status;

  Person({
    this.userName,
    this.userUID,
    this.userEmail,
    this.status,
  });

  Person.fromJson(Map<String, dynamic> json) {
    userName = json["userName"];
    userUID = json['userUID'];
    userEmail = json['userEmail'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["userName"] = userName;
    data['userUID'] = userUID;
    data['userEmail'] = userEmail;
    data['status'] = status;

    return data;
  }
}
