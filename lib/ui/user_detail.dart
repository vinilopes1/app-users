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
import 'package:fluttertoast/fluttertoast.dart';



class UserPage extends StatelessWidget {
  User user;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  BuildContext context;
  
  API api;

  UserPage(this.user);

  Future<User> updateUser(User user) async {
    final http.Response response = await http.put(baseUrl + '/api/users/'+ user.id.toString(), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
      body: jsonEncode(<String, String>{
        'name': user.name,
        'email': user.email,
        'phone': user.phone
      }),
    );
    if (response.statusCode == 204) {
      Navigator.pop(context);
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<Response> deleteUser(String userId) async {
    final http.Response response = await http.delete(baseUrl + '/api/users/' + userId, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },);
    if (response.statusCode == 204) {
      Navigator.pop(context);
    } else {
      throw Exception('Failed to delete user.');
    }
  }

  @override
  Widget build(BuildContext context) {
    emailController.text = this.user.email;
    nameController.text = this.user.name;
    phoneController.text = this.user.phone;
    this.context = context;

    return Scaffold(
        appBar: AppBar(
          title: Text(user.name),
          centerTitle: true,
          backgroundColor: Colors.deepPurple[600],
          actions: [
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                Share.share("teste");
              },
            )
          ],
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
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Created at: ",
                      style: TextStyle(color: Colors.black, fontSize: 15.0),
                    ),
                    Text(
                      user.createdAt,
                      style: TextStyle(color: Colors.black, fontSize: 15.0),
                    ),
                  ],
                )),
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
                          user = User.fromUpdate(user.id ,this.nameController.text, this.emailController.text, this.phoneController.text),
                          updateUser(user)
                        },
                        child: new Text("Save"),
                      ),
                    ),
                    Container(
                      width: 150.0,
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () =>
                            deleteUser(user.id.toString())
                        ,
                        textColor: Colors.white,
                        color: Colors.red,
                        padding: const EdgeInsets.all(8.0),
                        child: new Text(
                          "Delete",
                        ),
                      ),
                    )
                  ],
                )),
          ],
        )));
  }
}
