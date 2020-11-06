import 'package:appusers/infra/API.dart';
import 'package:appusers/ui/user_create.dart';
import 'package:appusers/ui/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';

import 'models/User.dart';

//const request = "http://localhost:8080/api/users";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),

    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  createState() => _MyHomePageState();
}

class _MyHomePageState extends State {

  var users = new List<User>();

  FutureOr onGoBack(dynamic value) {
    _getUsers();
    setState(() {});
  }

  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        users = list.map((model) => User.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getUsers();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[600],
      body: Stack(
        alignment: Alignment.center,

        children: <Widget>[
          Container(
            width: 400,
            height: 600,
            child: Image.asset('assets/image.png', fit: BoxFit.contain,),
          ),

          Positioned(
            child: Text("User App", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
            top: 40,
            left: 20,
          ),

          DraggableScrollableSheet(
            maxChildSize: 0.85,
            minChildSize: 0.1,
            builder: (BuildContext context, ScrollController scrolController){
              return Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),
                    ),
                    child: ListView.builder(

                      itemBuilder: (context, index){
                        return ListTile(
                          title: Text(users[index].name, style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold),),
                          subtitle: Text(users[index].email, style: TextStyle(color: Colors.grey[700]),),
                          trailing: Icon(Icons.check_circle, color: Colors.greenAccent,),
                          isThreeLine: true,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                              UserPage(users[index])
                            )).then((value) => onGoBack(value));
                          },
                        );
                      },
                      controller: scrolController,
                      itemCount: users.length,
                    ),
                  ),

                  Positioned(
                    child: FloatingActionButton(
                      child: Icon(Icons.add, color: Colors.white,),
                      backgroundColor: Colors.pinkAccent,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UserCreatePage())).
                        then((value) => onGoBack(value));
                      },
                    ),
                    top: -30,
                    right: 30,
                  )
                ],
              );
            },
          )

        ],
      ),
    );
  }
}

// Future<Map> getData() async {
//   Response response = await get(request);
//   return json.decode(response.body);
// }
