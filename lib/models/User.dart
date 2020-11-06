import 'dart:convert';

class User {
  int id;
  String name;
  String email;
  String phone;
  String createdAt;

  User(int id, String name, String email, String phone) {
    this.id = id;
    this.name = name;
    this.email = email;
    this.phone = phone;
    this.createdAt = createdAt;
  }

  User.fromPost(String name, String email, String phone){
    this.name = name;
    this.email = email;
    this.phone = phone;
  }

  User.fromUpdate(int id, String name, String email, String phone){
    this.id = id;
    this.name = name;
    this.email = email;
    this.phone = phone;
  }

  User.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        phone = json['phone'],
        createdAt = json['createdAt'];


  Map toJson() {
    return {'id': id, 'name': name, 'email': email, 'phone': phone, 'createdAt': createdAt};
  }
}