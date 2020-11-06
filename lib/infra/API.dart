import 'dart:async';
import 'package:appusers/models/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

const baseUrl = "http://192.168.0.114:8080";

class API {

  var headers = {
    'Content-Type': 'application/json'
  };

  static Future getUsers() {
    var url = baseUrl + "/api/users";
    return http.get(url);
  }

}