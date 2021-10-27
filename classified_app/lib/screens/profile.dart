///FALTA CAMIAR LA IMAGEN

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/auth.dart';
import 'package:classified_app/screens/login.dart';
// import 'package:classified_app/screens/login.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    getProfile();
    super.initState();
  }

  TextEditingController _nameUpdate = TextEditingController();
  TextEditingController _emailUpdate = TextEditingController();
  TextEditingController _mobileUpdate = TextEditingController();
  TextEditingController _imageUpdate = TextEditingController();

  Auth _auth = Get.put(Auth());
  var _user = {};

  getProfile() async {
    try {
      var token = _auth.token.value;
      print(token);

      http.post(Uri.parse("https://adlisting.herokuapp.com/user/profile"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          }).then((res) {
        print(res.body);
        var resp = json.decode(res.body);
        setState(() {
          _user = resp["data"];
          _nameUpdate.text = _user['name'];
          _emailUpdate.text = _user['email'];
          _mobileUpdate.text = _user['mobile'];
          _imageUpdate.text = _user['imgURL'];
        });

        print(resp);
        // setState(() {
        //   _user = resp["data"];
        // });
      }).catchError((e) {
        print(e);
      });
    } catch (e) {
      print(e);
    }
  }

  updateProfile() {
    var body = json.encode({
      "name": _nameUpdate.text,
      "email": _emailUpdate.text,
      "mobile": _mobileUpdate.text,
      // "imgURL": _imageUpdate,
    });
    print(_nameUpdate.text);

    var token = _auth.get();

    http
        .patch(Uri.parse("https://adlisting.herokuapp.com/user/"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token"
            },
            body: body)
        .then((res) {
      print(res.body);
      print("update");
      // var resp = json.decode(res.body);
      // _auth.set(resp["data"]["token"]);

      // print(resp["data"]["token"]);
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text("Edit Profile"),
      ),
      body: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          color: Colors.white,
          // child: Center(
          child: SingleChildScrollView(
            // reverse: true,
            child: Column(
              children: [
                SizedBox(
                  child: Container(
                    height: 25,
                  ),
                ),
                Container(
                    child: CircleAvatar(
                  radius: 50,
                  child: ClipOval(
                    child: Image.network(
                      _user['imgURL'],
                    ),
                  ),
                )),
                SizedBox(
                  child: Container(
                    height: 30,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _nameUpdate,
                      style: TextStyle(color: Colors.black),
                      decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black26, width: 2.0),
                        ),
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black26)),
                        // labelText: _user['name'],
                        labelStyle: TextStyle(color: Colors.black54),
                      ),
                    ),
                    SizedBox(
                      child: Container(
                        height: 20,
                      ),
                    ),
                    TextField(
                      controller: _emailUpdate,
                      style: TextStyle(color: Colors.black),
                      decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black26, width: 2.0),
                        ),
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black26)),
                        // labelText: _user['email'],
                        labelStyle: TextStyle(color: Colors.black54),
                      ),
                    ),
                    SizedBox(
                      child: Container(
                        height: 20,
                      ),
                    ),
                    TextField(
                      controller: _mobileUpdate,
                      style: TextStyle(color: Colors.black),
                      decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black26, width: 2.0),
                          ),
                          border: new OutlineInputBorder(
                              borderSide:
                                  new BorderSide(color: Colors.black26)),
                          // labelText: _user['mobile'],
                          labelStyle: TextStyle(
                            color: Colors.black54,
                          )),
                    ),
                    SizedBox(
                      child: Container(
                        height: 20,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.deepOrange,
                          minimumSize: Size(double.infinity, 50)),
                      onPressed: () {
                        updateProfile();
                        Get.to(Profile());
                      },
                      child: Text(
                        'Update Profile',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      child: Container(
                        height: 30,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: Colors.white,
                          minimumSize: Size(double.infinity, 50)),
                      onPressed: () {
                        Login();
                      },
                      child: Text(
                        'Logout',
                        style:
                            TextStyle(color: Colors.deepOrange, fontSize: 15),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
