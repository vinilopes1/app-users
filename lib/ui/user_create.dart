import 'dart:convert';

import 'package:appusers/infra/API.dart';
import 'package:appusers/main.dart';
import 'package:appusers/models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:share/share.dart';
import 'package:http/http.dart' as http;
import 'dart:async';



class UserCreatePage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  User user;
  String name, email, phone;
  BuildContext context;
  
  API api;

  Future<User> createUser(User user) async {
    String json = '{"name": "NO", "email":"NO", "phone":"NO"}';

    final http.Response response = await http.post(baseUrl + '/api/users/', headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
      body: jsonEncode(<String, String>{
        'name': user.name,
        'email': user.email,
        'phone': user.phone
      }),
    );
    if (response.statusCode == 201) {
      Navigator.pop(context);
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user.');
    }
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return Scaffold(
        appBar: AppBar(
          title: Text("New User"),
          centerTitle: true,
          backgroundColor: Colors.deepPurple[600],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Container(
              width: 600,
              height: 300,
              color: Colors.deepPurple[600],
              child: Icon(
                Icons.person_outline,
                color: Colors.white,
                size: 300,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: new TextFormField(
                decoration: new InputDecoration(
                  labelText: "Name",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "Name cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
                controller: nameController,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: new TextFormField(
                decoration: new InputDecoration(
                  labelText: "Email",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "Email cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: new TextFormField(
                decoration: new InputDecoration(
                  labelText: "Phone",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                keyboardType: TextInputType.phone,
                controller: phoneController,
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 150.0,
                      height: 50.0,
                      child: RaisedButton(
                        padding: const EdgeInsets.all(8.0),
                        textColor: Colors.white,
                        color: Colors.blue,
                        onPressed: () => {
                          user = User.fromPost(this.nameController.text, this.emailController.text, this.phoneController.text),
                          createUser(user)},
                        child: new Text("Create New User"),
                      ),
                    ),
                    Container(
                      width: 150.0,
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {},
                        textColor: Colors.white,
                        color: Colors.red,
                        padding: const EdgeInsets.all(8.0),
                        child: new Text(
                          "Cancel",
                        ),
                      ),
                    )
                  ],
                )),
          ],
        )));
  }
}
